function Get-ZertoEvent {
    [cmdletbinding( defaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "filter" )]
        [string]$startDate,
        [Parameter( ParameterSetName = "filter" )]
        [string]$endDate,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpg,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$eventType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$siteName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$siteIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$zorgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$entityType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$userName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$category,
        [Parameter( ParameterSetName = "filter" )]
        [string]$eventCategory,
        [Parameter( ParameterSetName = "filter" )]
        [string]$alertIdentifier,
        [Parameter( ParameterSetName = "eventId", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true )]
        [string[]]$eventId,
        [Parameter( ParameterSetName = "categories", Mandatory = $true )]
        [switch]$categories,
        [Parameter( ParameterSetName = "entities", Mandatory = $true )]
        [switch]$entities,
        [Parameter( ParameterSetName = "types", Mandatory = $true )]
        [switch]$types
    )

    begin {
        $baseUri = "events"
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $uri = "{0}" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "eventId" {
                $returnObject = foreach ( $id in $eventId ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
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
