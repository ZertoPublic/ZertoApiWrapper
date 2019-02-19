function Get-ZertoDatastore {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "datastoreIdentifier" )]
        [string[]]$datastoreIdentifier
    )

    begin {
        $baseUri = "datastores"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        if ( $PSCmdlet.ParameterSetName -eq "main" ) {
            $uri = "{0}" -f $baseUri
            $result = Invoke-ZertoRestRequest -uri $uri
            $returnObject.Add($result) | Out-Null
        } else {
            foreach ( $id in $datastoreIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $id
                $result = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($result) | Out-Null
            }
        }
    }

    end {
        return $returnObject
    }
}
