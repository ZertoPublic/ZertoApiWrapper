function Get-ZertoDatastore {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "datastoreIdentifier" )]
        [string[]]$datastoreIdentifier
    )

    begin {
        $baseUri = "datastores"
        $returnObject = @()
    }

    process {
        if ( $PSCmdlet.ParameterSetName -eq "main" ) {
            $uri = "{0}" -f $baseUri
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } else {
            $returnObject = foreach ( $id in $datastoreIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $id
                Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
