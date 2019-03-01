function Invoke-ZertoFailover {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Name of the VPG to Failover"
        )]
        [string]$vpgName,
        [Parameter(
            HelpMessage = "Checkpoint Identifier to use as the Point-In-Time to rollback to."
        )]
        [string]$checkpointIdentifier,
        [Parameter(
            HelpMessage = "0: After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.
            1: After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.
            2: The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.
            Default is the Site Settings setting."
        )]
        [string]$commitPolicy,
        [Parameter(
            HelpMessage = "The amount of time in seconds the failover waits in a Before Commit state to enable checking that the failover is as required before performing the commitPolicy setting. Default is the Site Setting"
        )]
        [string]$commitValue,
        [Parameter(
            HelpMessage = "0: The protected virtual machines are not touched before starting the failover. This assumes that you do not have access to the protected virtual machines. -- DEFAULT
        1: If the protected virtual machines have VMware Tools or Microsoft Integration Services available, the virtual machines are gracefully shut down, otherwise the failover operation fails. This is similar to performing a Move operation to a specified checkpoint.
        2: The protected virtual machines are forcibly shut down before starting the failover. If the protected virtual machines have VMware Tools or Microsoft Integration Services available, the procedure waits five minutes for the virtual machines to be gracefully shut down before forcibly powering them off. This is similar to performing a Move operation to a specified checkpoint."
        )]
        [int]$shutdownPolicy = 0,
        [Parameter(
            HelpMessage = "Time, in seconds, before VMs are forcibly turned off if the Force Shutdown option is seclected after attempting to gracefully shut down the VMs"
        )]
        [long]$timeToWaitBeforeShutdownInSec = 300,
        [Parameter(
            HelpMessage = "True: Enable reverse protection. The virtual machines are recovered on the recovery site and then protected using the default reverse protection settings.
            False: Do not enable reverse protection. The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set."
        )]
        [bool]$reverseProtection,
        [Parameter(
            HelpMessage = "Name(s) of VMs in the "
        )]
        [string[]]$vmName
    )

    begin {
        $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
        $baseUri = "vpgSettings/{0}/failover" -f $vpgId
        $body = [ordered]@{}
        foreach ($key in $PSBoundParameters.Keys) {
            if ($key -notlike 'vpgGroup' -or $key -notlike 'vmName') {
                $body[$key] = $PSBoundParameters['key']
            }
        }
        if ($PSBoundParameters.ContainsKey('vmName')) {
            $vmIdentifiers = @()
            $vmIdentifiers = foreach ( $name in $vmName ) {
                $(Get-ZertoProtectedVm -vmName $name).vmIdentifier
            }
            $body['VmIdentifiers'] = $vmIdentifiers
        }
    }

    process {
        Invoke-ZertoRestRequest -uri $baseUri -body $($body | ConvertTo-Json) -method "POST"
    }

    end {
        # Nothing to do!
    }
}
