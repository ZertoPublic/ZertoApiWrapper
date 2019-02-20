function Get-ZertoAlert {
    [cmdletbinding( defaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "alertId", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true )]
        [string[]]$alertId,
        [Parameter( ParameterSetName = "entities", Mandatory = $true )]
        [switch]$entities,
        [Parameter( ParameterSetName = "helpIdentifiers", Mandatory = $true )]
        [switch]$helpIdentifiers,
        [Parameter( ParameterSetName = "levels", Mandatory = $true )]
        [switch]$levels,
        [Parameter( ParameterSetName = "filter" )]
        [string]$startDate,
        [Parameter( ParameterSetName = "filter" )]
        [string]$endDate,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$siteIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$zorgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$level,
        [Parameter( ParameterSetName = "filter" )]
        [string]$helpIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$entity,
        [Parameter( ParameterSetName = "filter" )]
        [switch]$isDismissed
    )

    begin {
        $baseUri = "alerts"
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $uri = "{0}" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "alertId" {
                $returnObject = foreach ( $id in $alertId ) {
                    $uri = "{0}/{1}" -f $baseUri, $alertId
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

    end {
        return $returnObject
    }
}
