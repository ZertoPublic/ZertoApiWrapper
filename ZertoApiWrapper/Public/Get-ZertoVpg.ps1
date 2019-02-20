function Get-ZertoVpg {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "protectionGroupIdentifier", Mandatory = $true )]
        [Parameter( ParameterSetName = "checkpoints", Mandatory = $true )]
        [Parameter( ParameterSetName = "stats", Mandatory = $true )]
        [string[]]$protectionGroupIdentifier,
        [Parameter( ParameterSetName = "checkpoints", Mandatory = $true )]
        [switch]$checkpoints,
        [Parameter ( ParameterSetName = "checkpoints")]
        [string]$startDate,
        [Parameter ( ParameterSetName = "checkpoints")]
        [string]$endDate,
        [Parameter( ParameterSetName = "stats", Mandatory = $true )]
        [switch]$checkpointsStats,
        [Parameter( ParameterSetName = "entityTypes", Mandatory = $true  )]
        [switch]$entityTypes,
        [Parameter( ParameterSetName = "failoverCommitPolicies", Mandatory = $true  )]
        [switch]$failoverCommitPolicies,
        [Parameter( ParameterSetName = "failoverShutdownPolicies", Mandatory = $true  )]
        [switch]$failoverShutdownPolicies,
        [Parameter( ParameterSetName = "priorities", Mandatory = $true  )]
        [switch]$priorities,
        [Parameter( ParameterSetName = "retentionPolicies", Mandatory = $true  )]
        [switch]$retentionPolicies,
        [Parameter( ParameterSetName = "statuses", Mandatory = $true  )]
        [switch]$statuses,
        [Parameter( ParameterSetName = "subStatuses", Mandatory = $true  )]
        [switch]$subStatuses,
        [Parameter( ParameterSetName = "filter" )]
        [string]$name,
        [Parameter( ParameterSetName = "filter" )]
        [string]$status,
        [Parameter( ParameterSetName = "filter" )]
        [string]$subStatus,
        [Parameter( ParameterSetName = "filter" )]
        [string]$protectedSiteType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$recoverySiteType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$protectedSiteIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$recoverySiteIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$organizationName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$zorgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$priority,
        [Parameter( ParameterSetName = "filter" )]
        [string]$serviceProfileIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$backupEnabled
    )
    begin {
        $baseUri = "vpgs"
        $returnObject = @()
    }

    Process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }

            "protectionGroupIdentifier" {
                $returnObject = foreach ( $vpgId in $protectionGroupIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $vpgId
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            "checkpoints" {
                $filter = $false
                if ( $PSBoundParameters.ContainsKey("startDate") -or $PSBoundParameters.ContainsKey("endDate") ) {
                    $filter = $true
                    $filterTable = @{}
                    foreach ( $key in $PSBoundParameters.Keys ) {
                        if ( $key -eq "startDate" -or $key -eq "endDate") {
                            $filterTable[$key] = $PSBoundParameters[$key]
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

            "stats" {
                $returnObject = foreach ( $id in $protectionGroupIdentifier ) {
                    $uri = "{0}/{1}/checkpoints/stats" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

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
