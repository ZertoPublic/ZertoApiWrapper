function Get-ZertoVirtualizationSite {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "siteIdentifier",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "datastoreClusters",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "datastores",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "hostClusters",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "hosts",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "networks",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "resourcePools",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "vms",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "devices",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "folders",
            Mandatory = $true,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [string]$siteIdentifier,
        [Parameter(
            ParameterSetName = "datastoreClusters",
            Mandatory = $true,
            HelpMessage = "When selected, will return all datastore clusters at the specified site."
        )]
        [switch]$datastoreClusters,
        [Parameter(
            ParameterSetName = "datastores",
            Mandatory = $true,
            HelpMessage = "When selected, will return all datastores at the specified site."
        )]
        [switch]$datastores,
        [Parameter(
            ParameterSetName = "devices",
            Mandatory = $true,
            HelpMessage = "When selected, will return all devices at the specified site."
        )]
        [switch]$devices,
        [Parameter(
            ParameterSetName = "devices",
            Mandatory = $false,
            HelpMessage = "The identifier of the host for which to return all devices."
        )]
        [Parameter(
            ParameterSetName = "hosts",
            Mandatory = $false,
            HelpMessage = "The identifier of the host at the selected site to return information for only one host."
        )]
        [string]$hostIdentifier,
        [Parameter(
            ParameterSetName = "folders",
            Mandatory = $true,
            HelpMessage = "Return all folders at the selected site."
        )]
        [switch]$folders,
        [Parameter(
            ParameterSetName = "hostClusters",
            Mandatory = $true,
            HelpMessage = "Return all host clusters at the selected site."
        )]
        [switch]$hostClusters,
        [Parameter(
            ParameterSetName = "hosts",
            Mandatory = $true,
            HelpMessage = "Return all hosts at the selected site. If a host identifier is provided, return only that host."
        )]
        [switch]$hosts,
        [Parameter(
            ParameterSetName = "networks",
            Mandatory = $true,
            HelpMessage = "Return all networks at the selected site."
        )]
        [switch]$networks,
        [Parameter(
            ParameterSetName = "resourcePools",
            Mandatory = $true,
            HelpMessage = "Return all resource pools at the selected site."
        )]
        [switch]$resourcePools,
        [Parameter(
            ParameterSetName = "vms",
            Mandatory = $true,
            HelpMessage = "Return all VMs at the selected site."
        )]
        [switch]$vms
    )

    begin {
        $baseUri = "virtualizationsites"
        $returnObject = @()
    }

    process {
        # Return information based on ParameterSetName invoked.
        switch ( $PSCmdlet.ParameterSetName ) {

            # If no ParameterSetName is specified, return all data
            "main" {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }

            # If devices is specified along with a hostId, build return just that host information, otherwise return all devices at the site
            #TODO - remove foreach, only one siteIdentifier can be specified.
            "devices" {
                $returnObject = foreach ( $id in $siteIdentifier ) {
                    if ( $PSBoundParameters.ContainsKey( "hostIdentifier" ) ) {
                        $uri = "{0}/{1}/devices?hostIdentifier={2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                    } else {
                        $uri = "{0}/{1}/devices" -f $baseUri, $siteIdentifier
                    }
                    Invoke-ZertoRestRequest -uri $uri
                }
            }

            # If hosts is specified along with a hostID, build and return just that host information, otherwise return all hosts at the site
            "hosts" {
                if ( $PSBoundParameters.ContainsKey( "hostIdentifier" ) ) {
                    $uri = "{0}/{1}/hosts/{2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                } else {
                    $uri = "{0}/{1}/hosts" -f $baseUri, $siteIdentifier
                }
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If siteIdentifier is specified, return information for that site.
            "siteIdentifier" {
                $uri = "{0}/{1}" -f $baseUri, $siteIdentifier
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # If a different ParameterSetName is selected, use that information to build the URI and return that information
            default {
                $uri = "{0}/{1}/{2}" -f $baseUri, $siteIdentifier, $PSCmdlet.ParameterSetName.ToLower()
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }
        }
    }

    end {
        return $returnObject
    }
}
