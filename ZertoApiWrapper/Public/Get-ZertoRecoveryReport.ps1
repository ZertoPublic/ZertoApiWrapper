<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoRecoveryReport {
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
            HelpMessage = "The page number the user wants to retrieve. Minimum value is 1."
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
            HelpMessage = "The name of the VPG. You can specify more than one VPG, separated by commas."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgName,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The type of recovery operations. Possible values are: 'Failover', 'Failover Test', or 'Move'"
        )]
        [ValidateSet("Failover", "Failover Test", "Move")]
        [string]$recoveryType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "Whether the recovery operation has completed."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$state
    )

    begin {
        $baseUri = "reports/recovery"
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
