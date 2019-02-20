function Get-ZertoZsspSession {
    [cmdletbinding( DefaultParameterSetName = "default" )]
    param(
        [Parameter( ParameterSetName = "zsspSessionIdentifier" )]
        [string[]]$zsspSessionIdentifier
    )

    begin {
        $baseUri = "zsspSessionIdentifier"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        if ( $PSCmdlet.ParameterSetName -eq "default" ) {
            $results = Invoke-ZertoRestRequest -uri $baseUri
            $returnObject.Add($results) | Out-Null
        } elseif ( $PSCmdlet.ParameterSetName -eq "zsspSessionIdentifier" ) {
            foreach ( $id in $zsspSessionIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $id
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }
        }
    }

    end {
        return $returnObject
    }
}
