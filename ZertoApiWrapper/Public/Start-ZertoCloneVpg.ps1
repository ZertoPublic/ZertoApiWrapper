<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Start-ZertoCloneVpg {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name of the VPG you wish to clone.",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "The identifier of the checkpoint to use for cloning. If unspecified, the latest checkpoint will be used."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("checkpointId")]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = "The datastore name where the clone is to be created. If unspecified, will auto select the datastore with the most free space."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$datastoreName,
        [Parameter(
            HelpMessage = "The name(s) of the VMs you wish to clone. If unspecified, all VMs in the VPG will be cloned."
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vmName
    )

    begin {
        $baseUri = "vpgs"
        $vpgInfo = Get-ZertoVpg -name $vpgName
        if ( -not $vpgInfo ) {
            Write-Error "VPG: $vpgName could not be found. Please check the name and try again."
        }
        $vpgIdentifier = $vpgInfo.vpgIdentifier
        if ( $PSBoundParameters.ContainsKey('datastoreName') ) {
            $recoverysiteIdentifier = $vpgInfo.recoverysite.identifier
            $recoverySiteDatastores = Get-ZertoVirtualizationSite -siteIdentifier $recoverysiteIdentifier -datastores
            $datastoreIdentifier = $($recoverySiteDatastores | Where-Object { $_.datastoreName -like $datastoreName }).DatastoreIdentifier
            if ( -not $datastoreIdentifier ) {
                Write-Error "Datastore: $datastoreName is not a valid datastore. Please check the name and try again." -ErrorAction Stop
            }
        }
        if ( $PSBoundParameters.ContainsKey('vmName') ) {
            $vpgVmInformation = Get-ZertoProtectedVm -vpgName $vpgName
            [System.Collections.ArrayList]$vmIdentifiers = @()
            foreach ( $name in $vmName ) {
                $selectedVm = $vpgVmInformation | Where-Object { $_.VmName.toLower() -eq $name.toLower() }
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
        $uri = "{0}/{1}/CloneStart" -f $baseUri, $vpgIdentifier
        $body = [ordered]@{ }
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
