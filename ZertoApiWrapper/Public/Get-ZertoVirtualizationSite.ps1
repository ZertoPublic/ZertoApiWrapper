function Get-ZertoVirtualizationSite {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "siteIdentifier", Mandatory = $true )]
        [Parameter( ParameterSetName = "datastoreClusters", Mandatory = $true )]
        [Parameter( ParameterSetName = "datastores", Mandatory = $true )]
        [Parameter( ParameterSetName = "hostClusters", Mandatory = $true )]
        [Parameter( ParameterSetName = "hosts", Mandatory = $true )]
        [Parameter( ParameterSetName = "networks", Mandatory = $true )]
        [Parameter( ParameterSetName = "resourcePools", Mandatory = $true )]
        [Parameter( ParameterSetName = "vms", Mandatory = $true )]
        # [string[]]$siteIdentifiers,
        [Parameter( ParameterSetName = "devices", Mandatory = $true )]
        [Parameter( ParameterSetName = "folders", Mandatory = $true )]
        [string]$siteIdentifier,
        [Parameter( ParameterSetName = "datastoreClusters", Mandatory = $true )]
        [switch]$datastoreClusters,
        [Parameter( ParameterSetName = "datastores", Mandatory = $true )]
        [switch]$datastores,
        [Parameter( ParameterSetName = "devices", Mandatory = $true )]
        [switch]$devices,
        [Parameter( ParameterSetName = "devices", Mandatory = $false )]
        [Parameter( ParameterSetName = "hosts", Mandatory = $false )]
        [string]$hostIdentifier,
        [Parameter( ParameterSetName = "folders", Mandatory = $true )]
        [switch]$folders,
        [Parameter( ParameterSetName = "hostClusters", Mandatory = $true )]
        [switch]$hostClusters,
        [Parameter( ParameterSetName = "hosts", Mandatory = $true )]
        [switch]$hosts,
        [Parameter( ParameterSetName = "networks", Mandatory = $true )]
        [switch]$networks,
        [Parameter( ParameterSetName = "resourcePools", Mandatory = $true )]
        [switch]$resourcePools,
        [Parameter( ParameterSetName = "vms", Mandatory = $true )]
        [switch]$vms
    )

    begin {
        $baseUri = "virtualizationsites"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $results = Invoke-ZertoRestRequest -uri $baseUri
                $returnObject.Add($results) | Out-Null
            }

            "devices" {
                foreach ( $id in $siteIdentifier ) {
                    if ( $PSBoundParameters.Contains( "hostIdentifier" ) ) {
                        $uri = "{0}/{1}/devices?hostIdentifier={2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                    } else {
                        $uri = "{0}/{1}/devices" -f $baseUri, $siteIdentifier
                    }
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results)
                }
            }

            "hosts" {
                if ( $PSBoundParameters.Contains( "hostIdentifier" ) ) {
                    $uri = "{0}/{1}/hosts/{2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                } else {
                    $uri = "{0}/{1}/hosts" -f $baseUri, $siteIdentifier
                }
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
            }

            "siteIdentifier" {
                # foreach ( $id in $siteIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $id
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
                # }
            }

            default {
                # foreach ( $id in $siteIdentifier ) {
                $uri = "{0}/{1}/{2}" -f $baseUri, $siteIdentifier, $PSCmdlet.ParameterSetName.ToLower()
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
                # }
            }
        }
    }

    end {
        return $returnObject
    }
}
