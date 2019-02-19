function Get-ZertoVra {
    [cmdletbinding(
        DefaultParameterSetName = "Default"
    )]
    param(
        [Parameter( ParameterSetName = "ipConfig" )]
        [switch]$ipconfigurationtypes,
        [Parameter( ParameterSetName = "Statuses" )]
        [switch]$statuses,
        [Parameter( ParameterSetName = "vraIdentifier" )]
        [string[]]$vraIdentifier
    )

    begin {
        $baseUri = "vras"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        if ( $ipconfigurationtypes ) {
            $uri = "{0}/ipconfigurationtypes" -f $baseUri
            $results = Invoke-ZertoRestRequest -uri $uri
            $returnObject = $results
        } elseif ( $statuses ) {
            $uri = "{0}/statuses" -f $baseUri
            $results = Invoke-ZertoRestRequest -uri $uri
            $returnObject = $results
        } elseif ( $PSCmdlet.ParameterSetName -eq "vraIdentifierifier" ) {
            foreach ( $vraId in $vraIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $vraId
                $results = Invoke-ZertoRestRequest -uri $uri
                $returnObject.Add($results)
            }
        } else {
            $uri = $baseUri
            $results = Invoke-ZertoRestRequest -uri $uri
            $returnObject = $results
        }
    }

    end {
        return $returnObject
    }
}
