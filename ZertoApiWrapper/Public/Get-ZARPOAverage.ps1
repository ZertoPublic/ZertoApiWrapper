<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZARPOAverage {
    [CmdletBinding()]
    param (
        [Parameter(
            Helpmessage = "The identifier of the VPG.",
            Mandatory
        )]
        [ValidateNotNullOrEmpty()]
        [string]$vpgIdentifier,
        [Parameter(
            HelpMessage = "The starting date of the report, in RFC 3339 standard ('1970-01-01T00:00:00Z'). If only the end date is added, the start date by default will be the end date minus 7 days."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            HelpMessage = "The end date of the report, in RFC 3339 standard ('1970-01-01T00:00:00Z'). The default is the current time."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate,
        [Parameter(
            HelpMessage = "The interval selected within the duration of the report. The interval can be 1-minute data granularity for up to 6 hours’ time frame, 1-hour data granularity for 6 hours to 15 days’ time frame or 1-day data granularity for 15 days up to 30 days’ time frame. Value should be submitted in Seconds"
        )]
        [ValidateRange(60, 2678400)]
        [Int32]$interval
    )

    $filter = Get-ZertoApiFilter -FilterTable $PSBoundParameters
    $uri = "reports/rpo-average{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
