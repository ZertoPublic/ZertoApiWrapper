function Copy-ZertoVpg {
    [CmdletBinding()]
    param (
        # VPG Name to Clone
        [Parameter(Mandatory,
            HelpMessage = "Name of the VPG to clone")]
        [ValidateNotNullOrEmpty()]
        [String]$VpgName,
        # Name of VMs to add to the VPG
        [Parameter(Mandatory,
            HelpMessage = "Name(s) of the Virtual Machine(s) to add to the VPG")]
        [ValidateNotNullOrEmpty()]
        [String[]]$VMs
    )

    begin {

    }

    process {
        $VpgIdToCopy = @{ VpgIdentifier = (Get-ZertoVpg -vpgName $VpgName).vpgIdentifier }
        if ( $null -eq $VpgIdToCopy.VpgIdentifier ) {
            Write-Error -Message "Unable to find a VPG with the name: $VpgName. Please check the name and try again."
            Break
        } elseif ($VpgIdToCopy.VpgIdentifier.Count -gt 1) {
            Write-Error -Message "More than one VPG was returned when searching for the VPG name: $VpgName. Please try again."
            Break
        }
        $BaseUri = "vpgSettings/copyVpgSettings"
        $UnprotectedVms = Get-ZertoUnprotectedVm
        $ProtectedVms = Get-ZertoProtectedVm
        $VMsToAdd = foreach ($VM in $VMs) {
            if ($UnprotectedVms.VmName -contains $VM) {
                $UnprotectedVms | Where-Object { $_.VmName -like $VM } | Select-Object -ExpandProperty VmIdentifier
            } elseif ($ProtectedVms.VmName -contains $VM) {
                $ProtectedVms | Where-Object { $_.VmName -like $VM } | Select-Object -ExpandProperty VmIdentifier
            } else {
                Write-Warning -Message "Unable to find VM with Name $VM. Skipping."
            }
        }
        $NewVpgId = Invoke-ZertoRestRequest -Uri $BaseUri -body ($VpgIdToCopy | ConvertTo-Json) -Method "POST"
        $Uri = "{0}/{1}/vms" -f $BaseUri, $NewVpgId.VpgIdentifier
        Invoke-ZertoRestRequest -Uri $Uri -Body ($VMsToAdd | ConvertTo-Json) -Method "PUT"
    }

    end {

    }
}
