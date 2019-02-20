function Get-ZertoVolume {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter( ParameterSetName = "filter" )]
        [string]$volumeType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpgIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$datastoreIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$protectedVmIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$owningVmIdentifier
    )

    begin {
        $baseUri = "volumes"
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            default {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }
        }
    }

    end {
        return $returnObject
    }
}
