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
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }

            "serviceProfileId" {
                foreach ( $id in $serviceProfileId ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results) | Out-Null
                }
            }

            default {
                $results = Invoke-ZertoRestRequest -uri $baseUri
                $returnObject.Add($results) | Out-Null
            }
        }
    }

    end {
        return $returnObject
    }
}
