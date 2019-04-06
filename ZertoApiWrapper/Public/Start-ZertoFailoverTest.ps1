<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Start-ZertoFailoverTest {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name of VPG to failover test",
            Mandatory = $true
        )]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "The identifier of the checkpoint to use for testing. If unspecified, the latest checkpoint will be used."
        )]
        [Alias("checkpointId")]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = "The name(s) of the VMs within the selected VPG you wish to test. If unspecified, all VMs in the VPG will be tested."
        )]
        [string[]]$vmName
    )

    begin {
        $baseUri = "vpgs"
        $vpgIdentifier = $(Get-ZertoVpg -name $vpgName).vpgIdentifier
        if ( -not $vpgIdentifier) {
            Write-Error "VPG: $vpgName Not Found. Please check the name and try again!" -ErrorAction Stop
        }
        if ( $PSBoundParameters.ContainsKey('vmName') ) {
            $vpgVmInformation = Get-ZertoProtectedVm -vpgName $vpgName
            [System.Collections.ArrayList]$vmIdentifiers = @()
            foreach ( $name in $vmName ) {
                $selectedVm = $vpgVmInformation | Where-Object {$_.VmName.toLower() -eq $name.toLower()}
                if ($null -eq $selectedVm) {
                    Write-Error "VM: $name NOT found in VPG $vpgName. Check the name and try again." -ErrorAction Stop
                } elseif ($vmIdentifiers.Contains($selectedVm.vmIdentifier.toString())) {
                    Write-Error "VM: $($selectedVm.VmName) specified more than once. Please check parameters and try again." -ErrorAction Stop
                } else {
                    $vmIdentifiers.Add($selectedVm.vmIdentifier.toString()) | Out-Null
                }
            }
            $body['VmIdentifiers'] = $vmIdentifiers
            if ($checkpointIdentifier) {
                $body['CheckpointIdentifier'] = $checkpointIdentifier
            }
        }
    }

    process {
        $uri = "{0}/{1}/FailoverTest" -f $baseUri, $vpgIdentifier
        if ($PSCmdlet.ShouldProcess($vpgName)) {
            Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
        }
    }

    end {
        #Nothing to do
    }
}
