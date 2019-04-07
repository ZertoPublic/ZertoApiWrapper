<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoFailover {
    [cmdletbinding( SupportsShouldProcess = $true )]
    param(
        #TODO - Refactor?
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Name of the VPG to Failover"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "Checkpoint Identifier to use as the Point-In-Time to rollback to."
        )]
        [Alias("checkpointId")]
        [ValidateNotNullOrEmpty()]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = "'Rollback': After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.
            'Commit': After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.
            'None': The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.
            Default is the Site Settings setting."
        )]
        [ValidateSet("Rollback", "Commit", "None")]
        [string]$commitPolicy = "Rollback",
        [Parameter(
            HelpMessage = "0: The protected virtual machines are not touched before starting the failover. This assumes that you do not have access to the protected virtual machines. -- DEFAULT
        1: If the protected virtual machines have VMware Tools or Microsoft Integration Services available, the virtual machines are gracefully shut down, otherwise the failover operation fails. This is similar to performing a Move operation to a specified checkpoint.
        2: The protected virtual machines are forcibly shut down before starting the failover. If the protected virtual machines have VMware Tools or Microsoft Integration Services available, the procedure waits five minutes for the virtual machines to be gracefully shut down before forcibly powering them off. This is similar to performing a Move operation to a specified checkpoint."
        )]
        [ValidateSet(0, 1, 2)]
        [int]$shutdownPolicy = 0,
        [Parameter(
            HelpMessage = "The amount of time in seconds the failover waits in a Before Commit state to enable checking that the failover is as required before performing the commitPolicy setting. Default is 60 Minutes (3600 Seconds)"
        )]
        [int]$timeToWaitBeforeShutdownInSec = 3600,
        [Parameter(
            HelpMessage = "True: Enable reverse protection. The virtual machines are recovered on the recovery site and then protected using the default reverse protection settings.
            False: Do not enable reverse protection. The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set."
        )]
        [bool]$reverseProtection,
        [Parameter(
            HelpMessage = "Name(s) of VMs in the VPG to failover"
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vmName
    )

    begin {
        $vpgId = $(Get-ZertoVpg -name $vpgName).vpgIdentifier
        if ( -not $vpgId) {
            Write-Error "VPG: $vpgName Not Found. Please check the name and try again!" -ErrorAction Stop
        }
        $baseUri = "vpgs/{0}/failover" -f $vpgId
        $body = [ordered]@{}
        # Setup Defaults
        $body['commitpolicy'] = $commitPolicy
        $body['TimeToWaitBeforeShutdownInSec'] = $timeToWaitBeforeShutdownInSec
        foreach ($param in $PSBoundParameters.GetEnumerator()) {
            if ($param.key -notlike 'vpgName' -and $param.key -notlike 'vmName' -and $param.key -notlike 'WhatIf' -and $param.key -notlike 'TimeToWaitBeforeShutdownInSec' -and $param.key -notlike 'commitpolicy') {
                $body[$param.key] = $param.value
            }
        }
        if ($PSBoundParameters.ContainsKey('vmName')) {
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
        }
    }

    process {
        if ($PSCmdlet.ShouldProcess("$vpgName with identifier $vpgId and these options $($body | convertto-json)")) {
            Invoke-ZertoRestRequest -uri $baseUri -body $($body | ConvertTo-Json) -method "POST"
        }
    }

    end {
        # Nothing to do!
    }
}
