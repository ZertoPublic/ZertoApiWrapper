function Get-ZertoZsspSession {
    [cmdletbinding( DefaultParameterSetName = "default" )]
    param(
        [Parameter( ParameterSetName = "zsspSessionIdentifier" )]
        [string[]]$zsspSessionIdentifier
    )

    begin {
        $baseUri = "zsspSessionIdentifier"
        $returnObject = @()
    }

    process {
        if ( $PSCmdlet.ParameterSetName -eq "default" ) {
            $returnObject = Invoke-ZertoRestRequest -uri $baseUri
        } elseif ( $PSCmdlet.ParameterSetName -eq "zsspSessionIdentifier" ) {
            $returnObject = foreach ( $id in $zsspSessionIdentifier ) {
                $uri = "{0}/{1}" -f $baseUri, $id
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
