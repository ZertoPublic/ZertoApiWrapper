function Get-ZertoRecoveryReport {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "filter" )]
        [string]$startTime,
        [Parameter( ParameterSetName = "filter" )]
        [string]$endTime,
        [Parameter( ParameterSetName = "filter" )]
        [string]$pageNumber,
        [Parameter( ParameterSetName = "filter" )]
        [string]$pageSize,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpgName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$recoveryType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$state
    )

    begin {
        $baseUri = "reports/recovery"
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            default {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }
        }
    }

    end {
        return $returnObject
    }
}
