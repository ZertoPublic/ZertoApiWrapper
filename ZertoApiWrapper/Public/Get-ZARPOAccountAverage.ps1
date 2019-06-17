<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZARPOAccountAverage {
    [CmdletBinding()]
    param (
        [Parameter(
            Helpmessage = "The ZORG identifier by which to filter the user's average RPO for a single account. If the ZORG identifier is omitted, statistics related to all sites, for a single account, is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier,
        [Parameter(
            HelpMessage = "The starting date of the report, in RFC 3339 standard ('1970-01-01T00:00:00Z'). If only the end date is added, the start date by default will be the end date minus 7 days."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            HelpMessage = "The end date of the report, in RFC 3339 standard ('1970-01-01T00:00:00Z'). The default is the current time."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate
    )

    $filter = Get-ZertoApiFilter -FilterTable $PSBoundParameters
    $uri = "reports/account-rpo-average{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
