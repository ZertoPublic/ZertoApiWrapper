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
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $results = Invoke-ZertoRestRequest -uri $baseUri
                $returnObject.Add($results) | Out-Null
            }

            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $results = New-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }

            "taskIdentifier" {
                foreach ( $id in $taskIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results)
                }
            }

            default {
                $uri = "{0}/{1}" -f $baseUri, $PSCmdlet.ParameterSetName
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }
        }
    }

    end {
        return $returnObject
    }
}
