<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZANetworkVpgAverageIOPS {
    [CmdletBinding()]
    param (
        [Parameter(
            HelpMessage = "The VPG identifier.",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgIdentifier,
        [Parameter(
            HelpMessage = "Start date in RFC 3339 standard ('1970-01-01T00:00:00Z'). If the start date is omitted, the default start date is 7 days before the end date."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            HelpMessage = "End date in RFC 3339 standard ('1970-01-01T00:00:00Z'). If the end date is omitted, the default end date is the current time."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate,
        [Parameter(
            HelpMessage = "The interval selected within the duration of the report. The interval can be per minute - for up to 6 hours, per hour - for 6 hours to 15 days, or per day - for 15 days up to 30 days. If an interval is not specified, the default is 60 seconds. Submit value in Seconds."
        )]
        [ValidateRange(60, 2678400)]
        [Int32]$interval
    )

    $filter = Get-ZertoAPIFilter -filtertable $PSBoundParameters
    $uri = "reports/vpg-network-iops-average{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
