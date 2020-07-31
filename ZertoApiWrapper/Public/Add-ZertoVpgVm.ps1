<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Add-ZertoVpgVm {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "Vpg Settings Identifier",
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ValueFromRemainingArguments
        )]
        [ValidateNotNullOrEmpty()]
        [String]$vpgSettingsIdentifier,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of VM(s) to add to the VPG"
        )]
        [ValidateNotNullOrEmpty()]
        [String[]]$Vm
    )

    begin {

    }

    process {
        $baseUrl = "vpgsettings/{0}" -f $vpgSettingsIdentifier
        $baseSettings = Get-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsIdentifier
        $unprotectedVms = Get-ZertoUnprotectedVm
        $protectedVms = Get-ZertoProtectedVm
        $vmMap = Get-Map -inputObject $unprotectedVms -key VmName -value VmIdentifier
        $vmMap = $vmMap + (Get-Map -inputObject $protectedVms -key VmName -value VmIdentifier)
        # Create array of VM identifiers
        $vmIdentifiers = foreach ($machine in $Vm) {
            if ($vmMap[$machine] -notin $baseSettings.Vms.vmIdentifier ) {
                # If the VM is unprotected, get the identifier
                $vmIdentifier = $unprotectedVms | Where-Object { $_.vmName -like $machine } | Select-Object -ExpandProperty vmIdentifier
                # If the VM is not unprotected, check the protected VMs
                if ( -not $vmIdentifier) {
                    # Get all identifiers to test if the VM is eligible to be a member of an additional VPG
                    $results = $protectedVms | Where-Object { $_.VmName -like $machine } | Select-Object -ExpandProperty vmIdentifier
                    $recoverySiteIdentifiers = $protectedVms | Where-Object { $_.VmName -like $machine } | Select-Object -ExpandProperty RecoverySite | Select-Object -ExpandProperty identifier
                    # If VM is currently a member of 3 VPGs, skip it. If it cannot be found, skip it. Otherwise, set the identifier
                    if ($baseSettings.basic.RecoverySiteIdentifier -in $recoverySiteIdentifiers) {
                        Write-Warning "$machine is already replicating to target site. It cannot be added to an additional VPG replicating to that site. Please check your configurations and try again. Skipping $machine"
                        continue
                    } elseif ($results.count -eq 3) {
                        Write-Warning "$machine is already a part of 3 VPGs and cannot be part of an additional VPG. Skipping $machine"
                        continue
                    } elseif ($results.count -eq 0) {
                        Write-Warning "$machine not found. Skipping $machine"
                        continue
                    } else {
                        $vmIdentifier = $results | Select-Object -First 1
                    }
                }
                # Create a custom object to store the information to easily convert to JSON. Return to vmIdentifiers array.
                $returnObject = New-Object PSObject
                $returnObject | Add-Member -MemberType NoteProperty -Name "VmIdentifier" -Value $vmIdentifier
                $returnObject
            } else {
                Write-Warning "$machine is already a member of this VPG Settings object. It will not be added again. Skipping $machine"
                continue
            }
        }
        if ($vmIdentifiers.Count -gt 0 -and $PSCmdlet.ShouldProcess($Vm, "Adding VM to Vpg")) {
            $baseSettings.Vms += $vmIdentifiers
            Invoke-ZertoRestRequest -uri $baseUrl -method PUT -body $($baseSettings | ConvertTo-Json -Depth 10)
        } else {
            Write-Warning "No VMs found to add. Please check your parameters and try again."
        }
    }

    end {

    }
}
