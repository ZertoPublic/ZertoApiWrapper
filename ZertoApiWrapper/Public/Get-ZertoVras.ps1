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
        $returnObject = @()
    }

    process {
        if ( $ipconfigurationtypes ) {
            $uri = "{0}/ipconfigurationtypes" -f $baseUri
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $statuses ) {
            $uri = "{0}/statuses" -f $baseUri
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        } elseif ( $PSCmdlet.ParameterSetName -eq "vraIdentifierifier" ) {
            $returnObject = foreach ( $vraId in $vraIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $vraId
                Invoke-ZertoRestRequest -uri $uri
            }
        } else {
            $uri = $baseUri
            $returnObject = Invoke-ZertoRestRequest -uri $uri
        }
    }

    end {
        return $returnObject
    }
}
