function Get-ZertoVra {
    [cmdletbinding(
        DefaultParameterSetName = "main"
    )]
    param(
        [Parameter( ParameterSetName = "ipConfigurationTypes" )]
        [switch]$ipconfigurationtypes,
        [Parameter( ParameterSetName = "statuses" )]
        [switch]$statuses,
        [Parameter( ParameterSetName = "vraIdentifier" )]
        [string[]]$vraIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vraName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$status,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vraVersion,
        [Parameter( ParameterSetName = "filter" )]
        [string]$hostVersion,
        [Parameter( ParameterSetName = "filter" )]
        [string]$ipAddress,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vraGroup,
        [Parameter( ParameterSetName = "filter" )]
        [string]$datastoreName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$datastoreClusterName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$networkName
    )

    begin {
        $baseUri = "vras"
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "ipConfigurationTypes" {
                $uri = "{0}/ipconfigurationtypes" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "statuses" {
                $uri = "{0}/statuses" -f $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            "vraIdentifierifier" {
                $returnObject = foreach ( $vraId in $vraIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $vraId
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            default {
                $uri = $baseUri
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
