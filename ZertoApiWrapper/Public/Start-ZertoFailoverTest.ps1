<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Start-ZertoFailoverTest {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Name of VPG to failover test",
            Mandatory = $true
        )]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "The identifier of the checkpoint to use for testing. If unspecified, the latest checkpoint will be used."
        )]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = "The name(s) of the VMs within the selected VPG you wish to test. If unspecified, all VMs in the VPG will be tested."
        )]
        [string[]]$vmName
    )

    begin {
        $baseUri = "vpgs"
        $vpgIdentifier = $(Get-ZertoVpg -name $vpgName).vpgIdentifier
        if ( $PSBoundParameters.ContainsKey('vmName') ) {
            $vmIdentifiers = @()
            $vmIdentifiers = foreach ( $name in $vmName ) {
                $(Get-ZertoProtectedVm -vmName $name).vmIdentifier
            }
        }
    }

    process {
        $uri = "{0}/{1}/FailoverTest" -f $baseUri, $vpgIdentifier
        $body = [ordered]@{}
        if ($checkpointIdentifier) {
            $body['CheckpointIdentifier'] = $checkpointIdentifier
        }
        if ( $PSBoundParameters.ContainsKey('vmName') ) {
            $vmIdentifiers = @()
            $vmIdentifiers = foreach ( $name in $vmName ) {
                $(Get-ZertoProtectedVm -vmName $name).vmIdentifier
            }
            $body['VmIdentifiers'] = $vmIdentifiers
        }
        Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
    }

    end {
        #Nothing to do
    }
}
