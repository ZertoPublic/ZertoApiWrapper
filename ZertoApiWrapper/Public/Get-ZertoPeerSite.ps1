function Get-ZertoPeerSite {
    [cmdletbinding( defaultParameterSetName = "main" )]
    param (
        [Parameter ( ParameterSetName = "pairingStatuses", Mandatory = $true )]
        [switch]$pairingStatuses,
        [Parameter ( ParameterSetName = "siteIdentifier",
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true )]
        [string[]]$siteIdentifier,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$peerName,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$paringStatus,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$location,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$hostName,
        [Parameter ( ParameterSetName = "filter" )]
        [string]$port
    )

    begin {
        $baseUri = "peersites"
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $uri = "{0}" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "siteIdentifier" {
                $returnObject = foreach ( $id in $siteIdentifier ) {
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
