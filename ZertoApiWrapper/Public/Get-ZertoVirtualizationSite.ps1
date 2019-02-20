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
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }

            "devices" {
                $returnObject = foreach ( $id in $siteIdentifier ) {
                    if ( $PSBoundParameters.ContainsKey( "hostIdentifier" ) ) {
                        $uri = "{0}/{1}/devices?hostIdentifier={2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                    } else {
                        $uri = "{0}/{1}/devices" -f $baseUri, $siteIdentifier
                    }
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            "hosts" {
                if ( $PSBoundParameters.ContainsKey( "hostIdentifier" ) ) {
                    $uri = "{0}/{1}/hosts/{2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                } else {
                    $uri = "{0}/{1}/hosts" -f $baseUri, $siteIdentifier
                }
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "siteIdentifier" {
                $uri = "{0}/{1}" -f $baseUri, $id
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            default {
                $uri = "{0}/{1}/{2}" -f $baseUri, $siteIdentifier, $PSCmdlet.ParameterSetName.ToLower()
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
