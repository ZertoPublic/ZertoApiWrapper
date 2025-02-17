<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoVpg {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "protectionGroupIdentifier",
            Mandatory,
            HelpMessage = "The identifier(s) of the Virtual Protection Group to return"
        )]
        [Parameter(
            ParameterSetName = "checkpoints",
            Mandatory,
            HelpMessage = "The identifier(s) of the Virtual Protection Group to return"
        )]
        [Parameter(
            ParameterSetName = "stats",
            Mandatory,
            HelpMessage = "The identifier(s) of the Virtual Protection Group to return"
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgId", "protectionGroupId", "pgId")]
        [string[]]$protectionGroupIdentifier,
        [Parameter(
            ParameterSetName = "checkpoints",
            Mandatory,
            HelpMessage = "Return checkpoints for the selected Virtual Protection Group."
        )]
        [switch]$checkpoints,
        [Parameter(
            ParameterSetName = "checkpoints",
            HelpMessage = "Return checkpoints after the specified start date. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            ParameterSetName = "checkpoints",
            HelpMessage = "Return checkpoints before the specified start date. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate,
        [Parameter(
            ParameterSetName = "stats", Mandatory,
            HelpMessage = "Return earliest and latest checkpoints for the selected Virtual Protection Group"
        )]
        [switch]$checkpointsStats,
        [Parameter(
            ParameterSetName = "entityTypes",
            Mandatory,
            HelpMessage = "Return Valid VPG entityTypes"
        )]
        [switch]$entityTypes,
        [Parameter(
            ParameterSetName = "failoverCommitPolicies",
            Mandatory,
            HelpMessage = "Valid Failover Commit Policies"
        )]
        [switch]$failoverCommitPolicies,
        [Parameter(
            ParameterSetName = "failoverShutdownPolicies",
            Mandatory,
            HelpMessage = "Valid Failover Shutdown Policies"
        )]
        [switch]$failoverShutdownPolicies,
        [Parameter(
            ParameterSetName = "priorities",
            Mandatory,
            HelpMessage = "Valid VPG priorities"
        )]
        [switch]$priorities,
        [Parameter(
            ParameterSetName = "retentionPolicies",
            Mandatory,
            HelpMessage = "Valid retention policies"
        )]
        [switch]$retentionPolicies,
        [Parameter(
            ParameterSetName = "statuses",
            Mandatory,
            HelpMessage = "Valid VPG statuses"
        )]
        [switch]$statuses,
        [Parameter(
            ParameterSetName = "subStatuses",
            Mandatory,
            HelpMessage = "Valid VPG sub statuses"
        )]
        [switch]$subStatuses,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the VPG."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgName")]
        [string]$name,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The status of the VPG. Please use 'Get-ZertoVpg -statuses' for valid values"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$status,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The substatus of the VPG. Please use 'Get-ZertoVpg -substatuses' for valid values"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$subStatus,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The protected site environment. This filter behaves in the same way as the sourceType filter. Please see Zerto API Documentation for vaild values and discriptions."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedSiteType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The recovery site environment. This filter behaves in the same way as the sourceType filter. Please see Zerto API Documentation for vaild values and discriptions."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoverySiteType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the protected site where the VPG virtual machines are protected."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedSiteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the protected site where the VPG virtual machines are recovered."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoverySiteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The ZORG for this VPG."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$organizationName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The internal identifier for the ZORG."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zorgIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The VPG priority. Possible values are: 'Low', 'Medium', 'High'"
        )]
        [ValidateSet("Low", "Medium", "High")]
        [string]$priority,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the service profile to use for the VPG when a Zerto Cloud Manager is used."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$serviceProfileIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "If backup is enabled."
        )]
        [switch]$backupEnabled
    )
    begin {
        $baseUri = "vpgs"
    }

    Process {
        # Process based on ParameterSetName
        switch ( $PSCmdlet.ParameterSetName ) {

            # When called with no parameters, return all values
            "main" {
                $uri = $baseUri
            }

            # When called with protectionGroupIdentifier, query for each id provided
            "protectionGroupIdentifier" {
                $uri = foreach ( $vpgId in $protectionGroupIdentifier ) {
                    "{0}/{1}" -f $baseUri, $vpgId
                }
            }

            # When checkpoints is called, determine if a filter is needed and query with or without the filter.
            "checkpoints" {
                $filter = $false
                if ( $PSBoundParameters.ContainsKey("startDate") -or $PSBoundParameters.ContainsKey("endDate") ) {
                    $filter = $true
                    $filterTable = @{ }
                    foreach ( $param in $PSBoundParameters.GetEnumerator() ) {
                        if ( $param.key -eq "startDate" -or $param.key -eq "endDate") {
                            $filterTable[$param.key] = $param.value
                        }
                    }
                    $filter = Get-ZertoApiFilter -filterTable $filterTable
                }
                $uri = foreach ( $id in $protectionGroupIdentifier ) {
                    if ( $filter ) {
                        "{0}/{1}/checkpoints{2}" -f $baseUri, $id, $filter
                    } else {
                        "{0}/{1}/checkpoints" -f $baseUri, $id
                    }
                }
            }

            # When stats are requested
            "stats" {
                $uri = foreach ( $id in $protectionGroupIdentifier ) {
                    "{0}/{1}/checkpoints/stats" -f $baseUri, $id
                }
            }

            # When filtering for VPGs build query string and return events
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
            }

            # Default is to build URI based on ParameterSetName and return results.
            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName.ToLower()
            }
        }
        foreach ($entry in $uri) {
            Invoke-ZertoRestRequest -uri $entry
        }
    }

    End {
    }
}
