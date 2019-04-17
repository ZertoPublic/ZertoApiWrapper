<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoResourcesReport {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Operations performed between the specified start Time and end Time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startTime,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Operations performed between the specified start Time and end Time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endTime,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The page number to retrieve. Minimum value is 1"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$pageNumber,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The number of reports to display in a single page. The maximum number of reports per page is 1000."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$pageSize,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the organization set up in the Zerto Cloud Manager."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zorgName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the virtual machine."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vmName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the VPG."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the protected site."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedSiteName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the cluster containing the host where the virtual machine in the recovery site resides."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedClusterName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The address or DNS name of the host where the virtual machine in the recovery site resides."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedHostName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the vDC organization in the protected site."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedOrgVdc,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the vCD organization in the protected site."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$protectedVdcOrg,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the recovery site."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoverySiteName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the cluster containing the host where the virtual machine in the recovery site resides."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryClusterName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The address or DNS name of the host where the virtual machine in the recovery site resides."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryHostName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the vDC organization in the recovery site."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryOrgVdc,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the recovery vCD organization."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$recoveryVdcOrg
    )

    begin {
        $baseUri = "reports/resources"
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
