<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Copy-ZertoVpg {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # VPG Name to Clone
        [Parameter(Mandatory,
            HelpMessage = "Name of the VPG to clone")]
        [ValidateNotNullOrEmpty()]
        [String]$SourceVpgName,
        # New VPG Name
        [Parameter(Mandatory,
            HelpMessage = "Name to assign the newly created VPG")]
        [ValidateNotNullOrEmpty()]
        [String]$NewVpgName, # Name of VMs to add to the VPG
        [Parameter(Mandatory,
            HelpMessage = "Name(s) of the Virtual Machine(s) to add to the VPG")]
        [ValidateNotNullOrEmpty()]
        [String[]]$VMs
    )

    begin {

    }

    process {
        $VpgIdToCopy = @{ VpgIdentifier = (Get-ZertoVpg -vpgName $SourceVpgName).vpgIdentifier }
        if ( $null -eq $VpgIdToCopy.VpgIdentifier ) {
            Write-Error -Message "Unable to find a VPG with the name: $SourceVpgName. Please check the name and try again."
            Break
        } elseif ($VpgIdToCopy.VpgIdentifier.Count -gt 1) {
            Write-Error -Message "More than one VPG was returned when searching for the VPG name: $SourceVpgName. Please try again."
            Break
        }
        $BaseUri = "vpgSettings/copyVpgSettings"
        $UnprotectedVms = Get-ZertoUnprotectedVm
        $ProtectedVms = Get-ZertoProtectedVm
        $VMsToAdd = foreach ($VM in $VMs) {
            if ($UnprotectedVms.VmName -contains $VM) {
                $VmId = $UnprotectedVms | Where-Object { $_.VmName -like $VM } | Select-Object -ExpandProperty VmIdentifier
            } elseif ($ProtectedVms.VmName -contains $VM) {
                $VmId = $ProtectedVms | Where-Object { $_.VmName -like $VM } | Select-Object -ExpandProperty VmIdentifier
            } else {
                Write-Warning -Message "Unable to find VM with Name $VM. Skipping."
            }
            $returnObject = New-Object PSObject
            $returnObject | Add-Member -MemberType NoteProperty -Name "VmIdentifier" -Value $VmId
            $returnObject
        }
        if ($PSCmdlet.ShouldProcess("$VMsToAdd", "Copying $SourceVpgName to $NewVpgName with Settings")) {
            $NewVpgId = Invoke-ZertoRestRequest -Uri $BaseUri -Body ($VpgIdToCopy | ConvertTo-Json) -Method "POST"
            $Uri = "{0}/{1}/vms" -f "vpgSettings", $NewVpgId
            foreach ($VM in $VMsToAdd) {
                $null = Invoke-ZertoRestRequest -Uri $Uri -Body ($VM | ConvertTo-Json) -Method "POST"
            }
            $Uri = "vpgSettings/{0}" -f $NewVpgId
            $CurrentSettings = Invoke-ZertoRestRequest -Uri $Uri
            $CurrentSettings.Basic.Name = $NewVpgName
            $Null = Invoke-ZertoRestRequest -Uri $Uri -Method "Put" -Body $($CurrentSettings | ConvertTo-Json -Depth 20)
            Save-ZertoVpgSetting -vpgSettingsIdentifier $NewVpgId
        }

    }

    end {

    }
}
