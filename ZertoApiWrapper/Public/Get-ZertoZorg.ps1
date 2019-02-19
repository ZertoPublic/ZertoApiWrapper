function Get-ZertoZorg {
    [cmdletbinding( DefaultParameterSetName = "default" )]
    param(
        [Parameter( ParameterSetName = "zorgIdentifier" )]
        [string[]]$zorgIdentifier
    )

    begin {
        $baseUri = "zorgs"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        if ( $PSCmdlet.ParameterSetName -eq "default" ) {
            $results = Invoke-ZertoRestRequest -uri $baseUri
            $returnObject.Add($results)
        } elseif ( $PSCmdlet.ParameterSetName -eq "zorgIdentifier" ) {
            foreach ( $id in $zorgIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $id
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
            }
        }
    }

    end {
        return $returnObject
    }
}
