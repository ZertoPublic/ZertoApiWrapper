<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoVpg {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "protectionGroupIdentifier",
            Mandatory = $true,
            HelpMessage = "The identifier(s) of the Virtual Protection Group to return"
        )]
        [Parameter(
            ParameterSetName = "checkpoints",
            Mandatory = $true,
            HelpMessage = "The identifier(s) of the Virtual Protection Group to return"
        )]
        [Parameter(
            ParameterSetName = "stats",
            Mandatory = $true,
            HelpMessage = "The identifier(s) of the Virtual Protection Group to return"
        )]
        [Alias("vpgId", "protectionGroupId", "pgId")]
        [string[]]$protectionGroupIdentifier,
        [Parameter(
            ParameterSetName = "checkpoints",
            Mandatory = $true,
            HelpMessage = "Return checkpoints for the selected Virtual Protection Group."
        )]
        [switch]$checkpoints,
        [Parameter(
            ParameterSetName = "checkpoints",
            HelpMessage = "Return checkpoints after the specified start date. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$startDate,
        [Parameter(
            ParameterSetName = "checkpoints",
            HelpMessage = "Return checkpoints before the specified start date. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$endDate,
        [Parameter(
            ParameterSetName = "stats", Mandatory = $true,
            HelpMessage = "Return earliest and latest checkpoints for the selected Virtual Protection Group"
        )]
        [switch]$checkpointsStats,
        [Parameter(
            ParameterSetName = "entityTypes",
            Mandatory = $true,
            HelpMessage = "Return Valid VPG entityTypes"
        )]
        [switch]$entityTypes,
        [Parameter(
            ParameterSetName = "failoverCommitPolicies",
            Mandatory = $true,
            HelpMessage = "Valid Failover Commit Policies"
        )]
        [switch]$failoverCommitPolicies,
        [Parameter(
            ParameterSetName = "failoverShutdownPolicies",
            Mandatory = $true,
            HelpMessage = "Valid Failover Shutdown Policies"
        )]
        [switch]$failoverShutdownPolicies,
        [Parameter(
            ParameterSetName = "priorities",
            Mandatory = $true,
            HelpMessage = "Valid VPG priorities"
        )]
        [switch]$priorities,
        [Parameter(
            ParameterSetName = "retentionPolicies",
            Mandatory = $true,
            HelpMessage = "Valid retention policies"
        )]
        [switch]$retentionPolicies,
        [Parameter(
            ParameterSetName = "statuses",
            Mandatory = $true,
            HelpMessage = "Valid VPG statuses"
        )]
        [switch]$statuses,
        [Parameter(
            ParameterSetName = "subStatuses",
            Mandatory = $true,
            HelpMessage = "Valid VPG sub statuses"
        )]
        [switch]$subStatuses,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the VPG."
        )]
        [Alias("vpgName")]
        [string]$name,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The status of the VPG. Please use 'Get-ZertoVpg -statuses' for valid values"
        )]
        [string]$status,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The substatus of the VPG. Please use 'Get-ZertoVpg -substatuses' for valid values"
        )]
        [string]$subStatus,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The protected site environment. This filter behaves in the same way as the sourceType filter. Please see Zerto API Documentation for vaild values and discriptions."
        )]
        [string]$protectedSiteType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The recovery site environment. This filter behaves in the same way as the sourceType filter. Please see Zerto API Documentation for vaild values and discriptions."
        )]
        [string]$recoverySiteType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the protected site where the VPG virtual machines are protected."
        )]
        [string]$protectedSiteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the protected site where the VPG virtual machines are recovered."
        )]
        [string]$recoverySiteIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The ZORG for this VPG."
        )]
        [string]$organizationName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The internal identifier for the ZORG."
        )]
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
        [string]$serviceProfileIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "If backup is enabled."
        )]
        [switch]$backupEnabled
    )
    begin {
        $baseUri = "vpgs"
        $returnObject = @()
    }

    Process {
        # Process based on ParameterSetName
        switch ( $PSCmdlet.ParameterSetName ) {

            # When called with no parameters, return all values
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }

            # When called with protectionGroupIdentifier, query for each id provided
            "protectionGroupIdentifier" {
                $returnObject = foreach ( $vpgId in $protectionGroupIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $vpgId
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # When checkpoints is called, determine if a filter is needed and query with or without the filter.
            "checkpoints" {
                $filter = $false
                if ( $PSBoundParameters.ContainsKey("startDate") -or $PSBoundParameters.ContainsKey("endDate") ) {
                    $filter = $true
                    $filterTable = @{}
                    foreach ( $param in $PSBoundParameters.GetEnumerator() ) {
                        if ( $param.key -eq "startDate" -or $param.key -eq "endDate") {
                            $filterTable[$param.key] = $param.value
                        }
                    }
                    $filter = Get-ZertoApiFilter -filterTable $filterTable
                }
                $returnObject = foreach ( $id in $protectionGroupIdentifier ) {
                    if ( $filter ) {
                        $uri = "{0}/{1}/checkpoints{2}" -f $baseUri, $id, $filter
                    } else {
                        $uri = "{0}/{1}/checkpoints" -f $baseUri, $id
                    }
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # When stats are requested
            "stats" {
                $returnObject = foreach ( $id in $protectionGroupIdentifier ) {
                    $uri = "{0}/{1}/checkpoints/stats" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # When filtering for VPGs build query string and return events
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # Default is to build URI based on ParameterSetName and return results.
            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName.ToLower()
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    End {
        return $returnObject
    }
}
