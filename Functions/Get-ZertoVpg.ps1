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
        $returnObject = [System.Collections.ArrayList]@()
    }

    Process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $results = Invoke-ZertoRestRequest -uri $baseUri
                $returnObject.Add($results) | Out-Null
            }

            "protectionGroupIdentifier" {
                foreach ( $vpgId in $protectionGroupIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $vpgId
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results)
                }
            }

            "checkpoints" {
                $filter = $false
                if ( $PSBoundParameters.Contains("startDate") -or $PSBoundParameters.Contains("endDate") ) {
                    $filter = $true
                    $filterTable = @{}
                    foreach ( $key in $PSBoundParameters.Keys ) {
                        if ( $key -eq "startDate" -or $key -eq "endDate") {
                            $filterTable[$key] = $PSBoundParameters[$key]
                        }
                    }
                    $filter = New-ZertoApiFilter -filterTable $filterTable
                }
                foreach ( $id in $protectionGroupIdentifier ) {
                    if ( $filter ) {
                        $uri = "{0}/{1}/checkpoints{2}" -f $baseUri, $id, $filter
                    } else {
                        $uri = "{0}/{1}/checkpoints" -f $baseUri, $id
                    }
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results)
                }
            }

            "stats" {
                foreach ( $id in $protectionGroupIdentifier ) {
                    $uri = "{0}/{1}/checkpoints/stats" -f $baseUri, $id
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results)
                }
            }

            "filter" {
                $filter = New-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
            }

            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName.ToLower()
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
            }
        }
    }

    End {
        return $returnObject
    }
}
