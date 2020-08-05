<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Remove-ZertoVpgVm {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(
            Mandatory,
            HelpMessage = "Name of the VPG that contains the VM you wish to remove",
            ParameterSetName = "VpgName"
        )]
        [ValidateNotNullOrEmpty()]
        [String]$VpgName,
        [Parameter(
            Mandatory,
            HelpMessage = "Name of VM(s) to remove from the VPG"
        )]
        [ValidateNotNullOrEmpty()]
        [String[]]$Vm
    )

    begin {

    }

    process {
        $VpgData = Get-ZertoVpg -vpgName $VpgName
        if (-not $VpgData) {
            Write-Error "Unable to find Vpg with name $VpgName. Please check your parameters and try again." -ErrorAction Stop
        } else {
            $protectedVms = Get-ZertoProtectedVm -vpgName $VpgData.VpgName
        }
        $VmIdentifiers = foreach ($machine in ($vm | Select-Object -Unique)) {
            if ($machine -in $protectedVms.VmName) {
                $protectedVms.VmName.Where( { $_.VmName -like $machine }) | Select-Object -ExpandProperty VmIdentifier
            } else {
                Write-Warning "$machine is not found in $VpgName. Check your parameters. Skipping $machine"
            }
        }
        if ($VmIdentifiers.Count -gt 0 -and $PSCmdlet.ShouldProcess(($Vm | Select-Object -Unique), "Removing VM(s): $($Vm | Select-Object -Unique) from Vpg $VpgName")) {
            $vpgSettingsIdentifier = New-ZertoVpgSettingsIdentifier -vpgIdentifier $VpgData.VpgIdentifier
            foreach ($identifier in $VmIdentifiers) {
                $url = "vpgSettings/{0}/vms/{1}" -f $vpgSettingsIdentifier, $identifier
                Invoke-ZertoRestRequest -uri $uri -method DELETE
            }
            Save-ZertoVpgSetting -vpgSettingsIdentifier $vpgSettingsIdentifier
        } else {
            Write-Warning "No VMs found to remove. Please check your parameters and try again."
        }
    }

    end {

    }
}
