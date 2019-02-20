function Get-ZertoTask {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param (
        [Parameter( ParameterSetName = "taskIdentifier" )]
        [string[]]$taskIdentifier,
        [Parameter( ParameterSetName = "types" )]
        [switch]$types,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$startedBeforeDate,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$startedAfterDate,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$completedAfterDate,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$completedBeforeDate,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$type,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$status
    )

    begin {
        $baseUri = "tasks"
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }

            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "taskIdentifier" {
                $returnObject = foreach ( $id in $taskIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
