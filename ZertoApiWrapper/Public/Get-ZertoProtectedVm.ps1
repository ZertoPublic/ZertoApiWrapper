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
        $returnObject = @()
    }

    process {
        switch ( $PSCmdlet.ParameterSetName ) {
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
                $returnObject.Add($results) | Out-Null
            }

            "vmIdentifier" {
                $returnObject = foreach ( $id in $vmIdentifier ) {
                    $uri = "{0}/{1}" -f $baseUri, $id
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = New-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
