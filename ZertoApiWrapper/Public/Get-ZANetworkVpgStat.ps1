<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZANetworkVpgStat {
    [CmdletBinding()]
    param (
        [Parameter(
            HelpMessage = "The VPG identifier.",
            Mandatory
        )]
        [string]$vpgIdentifier,
        [Parameter(
            HelpMessage = "Start date in RFC 3339 standard ('1970-01-01T00:00:00Z'). If the start date is omitted, the default start date is 7 days before the end date."
        )]
        [string]$startDate,
        [Parameter(
            HelpMessage = "End date in RFC 3339 standard ('1970-01-01T00:00:00Z'). If the end date is omitted, the default end date is the current time."
        )]
        [string]$endDate
    )

    $filter = Get-ZertoAPIFilter -filtertable $PSBoundParameters
    $uri = "reports/vpg-network-stats{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
