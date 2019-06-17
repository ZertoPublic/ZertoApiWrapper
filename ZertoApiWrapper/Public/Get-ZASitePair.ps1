<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZASitePair {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the site list. If the ZORG identifier is omitted, a list of all sites is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier,
        [Parameter(
            HelpMessage = "Start date in RFC 3339 standard ('1970-01-01T00:00:00Z'). If the start date is omitted, the default start date is 7 days before the end date."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            HelpMessage = "End date in RFC 3339 standard ('1970-01-01T00:00:00Z'). If the end date is omitted, the default endDate is the current date."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate
    )
    $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
    $uri = "reports/sites-list{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
