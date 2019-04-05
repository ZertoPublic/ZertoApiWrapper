<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Start-ZertoCloneVpg {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name of the VPG you wish to clone.",
            Mandatory = $true
        )]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "The identifier of the checkpoint to use for cloning. If unspecified, the latest checkpoint will be used."
        )]
        [Alias("checkpointId")]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = "The datastore name where the clone is to be created. If unspecified, will auto select the datastore with the most free space."
        )]
        [string]$datastoreName,
        [Parameter(
            HelpMessage = "The name(s) of the VMs you wish to clone. If unspecified, all VMs in the VPG will be cloned."
        )]
        [string[]]$vmName
    )

    begin {
        $baseUri = "vpgs"

        $vpgInfo = Get-ZertoVpg -name $vpgName
        $vpgIdentifier = $vpgInfo.vpgIdentifier
        if ( $PSBoundParameters.ContainsKey('datastoreName') ) {
            $recoverysiteIdentifier = $vpgInfo.recoverysite.identifier
            $recoverySiteDatastores = Get-ZertoVirtualizationSite -siteIdentifier $recoverysiteIdentifier -datastores
            $datastoreIdentifier = $($recoverySiteDatastores | Where-Object {$_.datastoreName -like $datastoreName}).DatastoreIdentifier
        }
        if ( $PSBoundParameters.ContainsKey('vmName') ) {
            $vmIdentifiers = @()
            $vmIdentifiers = foreach ( $name in $vmName ) {
                $(Get-ZertoProtectedVm -vmName $name).vmIdentifier
            }
        }
    }

    process {
        $uri = "{0}/{1}/CloneStart" -f $baseUri, $vpgIdentifier
        $body = [ordered]@{}
        if ( $PSBoundParameters.ContainsKey('checkpointIdentifier') ) {
            $body['checkpointId'] = $checkpointIdentifier
        }
        if ( $datastoreIdentifier ) {
            $body['DatastoreIdentifier'] = $datastoreIdentifier
        }
        if ( $vmIdentifiers ) {
            $body['VmIdentifiers'] = $vmIdentifiers
        }
        Write-Verbose $body
        if ($PSCmdlet.ShouldProcess("Clone Vpg")) {
            Invoke-ZertoRestRequest -uri $uri -body $($body | ConvertTo-Json) -method "POST"
        }
    }

    end {
        Write-Verbose "Call Submitted to $uri"
        Write-Verbose "With the following information: $($body | ConvertTo-Json)"
    }
}
