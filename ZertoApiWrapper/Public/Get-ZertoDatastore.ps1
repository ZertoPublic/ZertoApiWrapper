function Get-ZertoDatastore {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "datastoreIdentifier",
            HelpMessage = "datastoreIdentifier or array of datastoreIdentifiers to be queried"
        )]
        [string[]]$datastoreIdentifier
    )

    begin {
        $baseUri = "datastores"
        $returnObject = @()
    }

    process {
        # If command is called without parameters, return all datastores
        if ( $PSCmdlet.ParameterSetName -eq "main" ) {
            $uri = "{0}" -f $baseUri
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } else {
            # Return information for datastoreIdentifiers requested
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
