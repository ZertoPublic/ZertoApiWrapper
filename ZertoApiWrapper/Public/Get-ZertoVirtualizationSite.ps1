<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoVirtualizationSite {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "siteIdentifier",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "datastoreClusters",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "datastores",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "hostClusters",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "hosts",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "networks",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "resourcePools",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "vms",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "devices",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "folders",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [Parameter(
            ParameterSetName = "repositories",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("siteId")]
        [string]$siteIdentifier,
        [Parameter(
            ParameterSetName = "datastoreClusters",
            Mandatory,
            HelpMessage = "When selected, will return all datastore clusters at the specified site."
        )]
        [switch]$datastoreClusters,
        [Parameter(
            ParameterSetName = "datastores",
            Mandatory,
            HelpMessage = "When selected, will return all datastores at the specified site."
        )]
        [switch]$datastores,
        [Parameter(
            ParameterSetName = "devices",
            Mandatory,
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
        [ValidateNotNullOrEmpty()]
        [Alias("hostId")]
        [string]$hostIdentifier,
        [Parameter(
            ParameterSetName = "folders",
            Mandatory,
            HelpMessage = "Return all folders at the selected site."
        )]
        [switch]$folders,
        [Parameter(
            ParameterSetName = "hostClusters",
            Mandatory,
            HelpMessage = "Return all host clusters at the selected site."
        )]
        [switch]$hostClusters,
        [Parameter(
            ParameterSetName = "hosts",
            Mandatory,
            HelpMessage = "Return all hosts at the selected site. If a host identifier is provided, return only that host."
        )]
        [switch]$hosts,
        [Parameter(
            ParameterSetName = "networks",
            Mandatory,
            HelpMessage = "Return all networks at the selected site."
        )]
        [switch]$networks,
        [Parameter(
            ParameterSetName = "resourcePools",
            Mandatory,
            HelpMessage = "Return all resource pools at the selected site."
        )]
        [switch]$resourcePools,
        [Parameter(
            ParameterSetName = "vms",
            Mandatory,
            HelpMessage = "Return all VMs at the selected site."
        )]
        [switch]$vms,
        [Parameter(
            ParameterSetName = "repositories",
            Mandatory,
            HelpMessage = "The identifier of the Zerto Virtual Manager site."
        )]
        [switch]$repositories
    )

    begin {

    }

    process {
        # Return information based on ParameterSetName invoked.
        $baseUri = "virtualizationsites"
        switch ( $PSCmdlet.ParameterSetName ) {
            # If no ParameterSetName is specified, return all data
            "main" {
                $uri = $baseUri
            }

            # If devices is specified along with a hostId, build return just that host information, otherwise return all devices at the site
            "devices" {
                if ( $PSBoundParameters.ContainsKey( "hostIdentifier" ) ) {
                    $uri = "{0}/{1}/devices?hostIdentifier={2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                } else {
                    $uri = "{0}/{1}/devices" -f $baseUri, $siteIdentifier
                }
            }

            # If hosts is specified along with a hostID, build and return just that host information, otherwise return all hosts at the site
            "hosts" {
                if ( $PSBoundParameters.ContainsKey( "hostIdentifier" ) ) {
                    $uri = "{0}/{1}/hosts/{2}" -f $baseUri, $siteIdentifier, $hostIdentifier
                } else {
                    $uri = "{0}/{1}/hosts" -f $baseUri, $siteIdentifier
                }
            }

            # If siteIdentifier is specified, return information for that site.
            "siteIdentifier" {
                $uri = "{0}/{1}" -f $baseUri, $siteIdentifier
            }

            # If a different ParameterSetName is selected, use that information to build the URI and return that information
            default {
                $uri = "{0}/{1}/{2}" -f $baseUri, $siteIdentifier, $PSCmdlet.ParameterSetName.ToLower()
            }
        }
        Invoke-ZertoRestRequest -uri $uri
    }

    end {

    }
}
