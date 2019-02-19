function Get-ZertoProtectedVm {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param (
        [Parameter( ParameterSetName = "vmIdentifier", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true )]
        [string[]]$vmIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vpgName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$vmName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$status,
        [Parameter( ParameterSetName = "filter" )]
        [string]$substatus,
        [Parameter( ParameterSetName = "filter" )]
        [string]$organizationName,
        [Parameter( ParameterSetName = "filter" )]
        [string]$priority,
        [Parameter( ParameterSetName = "filter" )]
        [string]$protectedSiteType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$recoverySiteType,
        [Parameter( ParameterSetName = "filter" )]
        [string]$protectedSiteIdentifier,
        [Parameter( ParameterSetName = "filter" )]
        [string]$recoverySiteIdentifier
    )

    begin {
        $baseUri = "vms"
        $returnObject = [System.Collections.ArrayList]@()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $results = Invoke-ZertoRestRequest -uri $baseUri
                $returnObject.Add($results) | Out-Null
            }

            "vmIdentifier" {
                foreach ( $id in $vmIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    $results = Invoke-ZertoRestRequest -uri $uri
                    $returnObject.Add($results)
                }
            }

            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $results = New-ZertoRestRequest -uri $uri
                $returnObject.Add($results) | Out-Null
            }
        }
    }

    end {
        return $returnObject
    }
}
