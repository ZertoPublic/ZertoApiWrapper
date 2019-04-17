<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoZsspSession {
    [cmdletbinding( DefaultParameterSetName = "default" )]
    param(
        [Parameter(
            ParameterSetName = "zsspSessionIdentifier",
            HelpMessage = "ZSSP Session Id(s) to get information."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("zsspSessionId")]
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
