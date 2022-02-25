<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZertoMove {
    [CmdletBinding( DefaultParameterSetName = "id", SupportsShouldProcess = $true )]
    param(
        [Parameter(
            ParameterSetName = 'name',
            HelpMessage = "Name(s) of the VPG(s) you want to move.",
            Mandatory
        )]
        [Parameter(
            ParameterSetName = 'commitName',
            HelpMessage = "Name(s) of the VPG(s) you want to move.",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$vpgName,
        [Parameter(
            ParameterSetName = 'id',
            HelpMessage = "ID(s) of the VPG(s) you want to move.",
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [Parameter(
            ParameterSetName = 'commitId',
            HelpMessage = "ID(s) of the VPG(s) you want to move.",
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [ValidateNotNullOrEmpty()]
        [guid[]]$vpgIdentifier,
        [Parameter(
            ParameterSetName = 'commitName',
            HelpMessage = "'Rollback': After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.
            'Commit': After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.
            'None': The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.
            Default is the Site Settings setting.",
            Mandatory
        )]
        [Parameter(
            ParameterSetName = 'commitId',
            HelpMessage = "'Rollback': After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.
            'Commit': After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.
            'None': The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.
            Default is the Site Settings setting.",
            Mandatory
        )]
        [ValidateSet("Rollback", "Commit", "None")]
        [string]$commitPolicy,
        [Parameter(
            ParameterSetName = 'commitName',
            HelpMessage = "The amount of time, in seconds, the Move is in a 'Before Commit' state, before performing the commitPolicy setting. If omitted, the site settings default will be applied."
        )]
        [Parameter(
            ParameterSetName = 'commitId',
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
            HelpMessage = "Do not enable reverse protection. The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set."
        )]
        [switch]$disableReverseProtection,
        [Parameter(
            HelpMessage = "Prevent the protected virtual machines from being deleted in the protected site. Using this setting disables reverse protection."
        )]
        [switch]$keepSourceVms,
        [Parameter(
            HelpMessage = "Continue the Move operation in case of failure of script executing prior the operation. If this switch is not set a failure of the script executing prior to the operation will cause the operation to fail."
        )]
        [switch]$ContinueOnPreScriptFailure
    )

    begin {
        $baseUri = "vpgs"
        $body = @{
            forceShutdown              = $forceShutdown.IsPresent
            ContinueOnPreScriptFailure = $ContinueOnPreScriptFailure.IsPresent
            keepSourceVms              = $keepSourceVms.IsPresent
            reverseProtection          = -not $disableReverseProtection.IsPresent
        }

        if ( $keepSourceVms.IsPresent -and -not $disableReverseProtection.IsPresent ) {
            Write-Verbose 'Disabling reverse protection as keepSourceVms requires it'
            $body['reverseProtection'] = $false
        }

        if ($PSBoundParameters.ContainsKey('commitPolicy')) {
            $body['commitPolicy'] = $commitPolicy
            if ($PSBoundParameters.ContainsKey('commitPolicyTimeout')) {
                $body['commitPolicyTimeout'] = $commitPolicyTimeout
            }
        }
    }

    process {

        switch ($PSCmdlet.ParameterSetName) {
            { $_ -in 'name', 'commitName' } {
                $vpgIds = foreach ($name in $vpgName) {
                    $vpgId = $(Get-ZertoVpg -name $name).vpgIdentifier
                    if ( -not $vpgId ) {
                        Write-Error "VPG: '$name' not found. Please check the name and try again. Skipping"
                    } else {
                        Write-Verbose "VPG: $name, ID: $vpgId"
                        $vpgId
                    }
                }
            }

            { $_ -in 'id', 'commitId' } {
                $vpgIds = $vpgIdentifier
            }
        }

        foreach ($thisId in $vpgIds) {
            $uri = "{0}/{1}/move" -f $baseUri, $thisId
            if ($PSCmdlet.ShouldProcess("Moving VPG: $thisId with settings: $($body | ConvertTo-Json)")) {
                Invoke-ZertoRestRequest -uri $uri -method "POST" -body $($body | ConvertTo-Json)
            }
        }
    }

    end {
        # Nothing to do.
    }
}
