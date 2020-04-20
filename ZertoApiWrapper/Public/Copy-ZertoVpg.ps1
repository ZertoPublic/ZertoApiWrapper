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
            Throw "Unable to find a VPG with the name: $SourceVpgName. Please check the name and try again."
        }
        $BaseUri = "vpgSettings/copyVpgSettings"
        $VmsMap = Get-Map -InputObject (Get-ZertoUnprotectedVm) -Key 'VmName' -Value 'VmIdentifier'
        $VmsMap += Get-Map -InputObject (Get-ZertoProtectedVm) -Key 'VmName' -Value 'VmIdentifier'
        $VMsToAdd = foreach ($VM in $VMs) {
            if ($VmsMap.Keys -contains $VM) {
                [PSCustomObject]@{
                    VmIdentifier = $VmsMap[$VM]
                }
            } else {
                Write-Warning -Message "Unable to find VM with Name $VM. Skipping."
            }
        }
        if ($PSCmdlet.ShouldProcess("$VMsToAdd", "Copying $SourceVpgName to $NewVpgName with Settings")) {
            $NewVpgId = Invoke-ZertoRestRequest -Uri $BaseUri -Body ($VpgIdToCopy | ConvertTo-Json) -Method "POST"
            $Uri = "{0}/{1}/vms" -f "vpgSettings", $NewVpgId
            foreach ($VM in $VMsToAdd) {
                $null = Invoke-ZertoRestRequest -Uri $Uri -Body ($VM | ConvertTo-Json) -Method "POST" -ErrorAction Stop
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
