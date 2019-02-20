function Get-ZertoServiceProfile {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param (
        [Parameter( ParameterSetName = "siteIdentifier" )]
        [string]$siteIdentifier,
        [Parameter( ParameterSetName = "serviceProfileId" )]
        [string[]]$serviceProfileId
    )

    begin {
        $baseUri = "serviceprofiles"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "siteIdentifier" {
                $uri = "{0}?site={1}" -f $baseUri, $siteIdentifier
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "serviceProfileId" {
                $returnObject = foreach ( $id in $serviceProfileId ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
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
