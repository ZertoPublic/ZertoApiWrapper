function Get-ZertoResourcesReport {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Operations performed between the specified start Time and end Time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$startTime,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Operations performed between the specified start Time and end Time (inclusive) are displayed. Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'. Adding Z to the end of the time sets the time to UTC."
        )]
        [string]$endTime,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The page number to retrieve. Minimum value is 1"
        )]
        [string]$pageNumber,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The number of reports to display in a single page. The maximum number of reports per page is 1000."
        )]
        [string]$pageSize,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the organization set up in the Zerto Cloud Manager."
        )]
        [string]$zorgName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the virtual machine."
        )]
        [string]$vmName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the VPG."
        )]
        [string]$vpgName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the protected site."
        )]
        [string]$protectedSiteName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the cluster containing the host where the virtual machine in the recovery site resides."
        )]
        [string]$protectedClusterName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The address or DNS name of the host where the virtual machine in the recovery site resides."
        )]
        [string]$protectedHostName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the vDC organization in the protected site."
        )]
        [string]$protectedOrgVdc,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the vCD organization in the protected site."
        )]
        [string]$protectedVdcOrg,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the recovery site."
        )]
        [string]$recoverySiteName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the cluster containing the host where the virtual machine in the recovery site resides."
        )]
        [string]$recoveryClusterName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The address or DNS name of the host where the virtual machine in the recovery site resides."
        )]
        [string]$recoveryHostName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the vDC organization in the recovery site."
        )]
        [string]$recoveryOrgVdc,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The name of the recovery vCD organization."
        )]
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
