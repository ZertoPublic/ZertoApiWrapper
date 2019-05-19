<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMove {
    [CmdletBinding( DefaultParameterSetName = "main", SupportsShouldProcess = $true )]
    param(
        [Parameter(
            HelpMessage = "Name(s) of the VPG(s) you want to move.",
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
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
        # Min 5 Minutes, Max 24 Hours, Default Site Settigns.
        [ValidateRange(300, 86400)]
        [Int]$commitPolicyTimeout,
        [Parameter(
            HelpMessage = "If this switch is specified, Zerto will attempt to gracefully shut down the Virtual Machines. If the machines do not poweroff within 5 minutes, they will be forcibly powering them off."
        )]
        [switch]$forceShutdown,
        [Parameter(
            ParameterSetName = "disableReverseProtection",
            HelpMessage = "Do not enable reverse protection. The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set.",
            Mandatory = $true
        )]
        [switch]$disableReverseProtection,
        [Parameter(
            ParameterSetName = "keepSourceVms",
            HelpMessage = "Prevent the protected virtual machines from being deleted in the protected site. Using this setting disables reverse protection.",
            Mandatory = $true
        )]
        [switch]$keepSourceVms,
        [Parameter(
            HelpMessage = "Continue the Move operation in case of failure of script executing prior the operation. If this switch is not set a failure of the script executing prior to the operation will cause the operation to fail."
        )]
        [switch]$ContinueOnPreScriptFailure
    )

    begin {
        $baseUri = "vpgs"
    }

    process {
        $body = @{ }
        #TODO - use a foreach loop to populate the body without all the if statments
        if ($PSBoundParameters.ContainsKey('commitPolicy')) {
            $body['commitPolicy'] = $commitPolicy
        }
        if ($PSBoundParameters.ContainsKey('commitPolicyTimeout')) {
            $body['commitPolicyTimeout'] = $commitPolicyTimeout
        }
        if ($PSBoundParameters.ContainsKey('forceShutdown')) {
            $body['forceShutdown'] = $true
        } else {
            $body['forceShutdown'] = $false
        }
        if ($PSBoundParameters.ContainsKey('ContinueOnPreScriptFailure')) {
            $body['ContinueOnPreScriptFailure'] = $true
        } else {
            $body['ContinueOnPreScriptFailure'] = $false
        }
        switch ($PSCmdlet.ParameterSetName) {
            "disableReverseProtection" {
                $body['reverseProtection'] = $false
                $body['keepSourceVms'] = $false
            }

            "keepSourceVms" {
                $body['reverseProtection'] = $false
                $body['keepSourceVms'] = $true
            }

            "main" {
                $body['reverseProtection'] = $true
                $body['keepSourceVms'] = $false
            }
        }
        foreach ($name in $vpgName) {
            $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
            if ( -not $vpgId ) {
                Write-Error "VPG: $name not found. Please check the name and try again. Skipping"
            } else {
                $uri = "{0}/{1}/move" -f $baseUri, $vpgId
                if ($PSCmdlet.ShouldProcess("Moving VPG: $name wiht settings: $($body | convertto-json)")) {
                    Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
                }
            }
        }
    }

    end {
        # Nothing to do.
    }
}
