<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAJournalStatusProportion {
    [CmdletBinding()]
    param (
        [Parameter(
            HelpMessage = "The identifier of the VPG.",
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
        [string]$endDate
    )

    $filter = Get-ZertoApiFilter -filtertable $PSBoundParameters
    $uri = "reports/journal-statuses-proportions{0}" -f $filter
    Invoke-ZARestRequest -uri $uri
}
