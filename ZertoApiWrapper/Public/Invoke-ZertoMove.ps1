<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMove {
    [CmdletBinding()]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) you want to move.",
            Mandatory = $true
        )]
        [string[]]$vpgName,
        [Parameter(
            HelpMessage = "'Rollback': After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.
            'Commit': After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.
            'None': The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.
            Default is the Site Settings setting."
        )]
        [ValidateSet("Rollback", "Commit", "None")]
        [string]$commitPolicy,
        [Parameter(
            HelpMessage = "The amount of time, in seconds, the Move is in a 'Before Commit' state, before performing the commitPolicy setting. If omitted, the site settings default will be applied."
        )]
        [Int32]$commitPolicyTimeout,
        [Parameter(
            HelpMessage = "False: If a utility (VMware Tools) is installed on the protected virtual machines, the procedure waits five minutes for the virtual machines to be gracefully shut down before forcibly powering them off.
            True: To force a shutdown of the virtual machines.
            Default: True"
        )]
        [bool]$forceShutdown,
        [Parameter(
            HelpMessage = "False: Do not enable reverse protection. The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set.
            True: Enable reverse protection. The virtual machines are recovered on the recovery site and then protected using the default reverse protection settings.
            Default Value: True
            Note: If ReverseProtection is set to True, the KeepSourceVMs should be ignored because the virtual disks of the VMs are used for replication and cannot have VMs attached."
        )]
        [bool]$reverseProtection = $false,
        [Parameter(
            HelpMessage = "False: Remove the protected virtual machines from the protected site.
            True: Prevent the protected virtual machines from being deleted in the protected site.
            Default: False"
        )]
        [bool]$keepSourceVms = $false,
        [Parameter(
            HelpMessage = "False: Do not continue the Move operation in case of failure of script executing prior the operation.
            True: Continue the Move operation in case of failure of script executing prior the operation.
            Default: False"
        )]
        [bool]$continueOnPreScriptFailure
    )

    begin {
        $baseUri = "vpgs"
        $body = [ordered]@{}
        if ($PSBoundParameters.ContainsKey('commitPolicy')) {
            $body['commitPolicy'] = $commitPolicy
        }
        if ($PSBoundParameters.ContainsKey('commitPolicyTimeout')) {
            $body['commitPolicyTimeout'] = $commitPolicyTimeout
        }
        if ($PSBoundParameters.ContainsKey('forceShutdown')) {
            $body['forceShutdown'] = $forceShutdown
        }
        if ($PSBoundParameters.ContainsKey('reverseProtection')) {
            $body['reverseProtection'] = $reverseProtection
        }
        if ($PSBoundParameters.ContainsKey('keepSourceVms')) {
            $body['keepSourceVms'] = $keepSourceVms
        }
        if ($PSBoundParameters.ContainsKey('continueOnPreScriptFail')) {
            $body['continueOnPreScriptFail'] = $continueOnPreScriptFailure
        }
    }

    process {
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            $uri = "{0}/{1}/move" -f $baseUri, $vpgId
            Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
        }
    }

    end {
        # Nothing to do.
    }
}
