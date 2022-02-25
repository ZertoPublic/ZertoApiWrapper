<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAEvent {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the user's events. If the ZORG identifier is omitted, events is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier,
        [Parameter(
            HelpMessage = "The event category (events/alertsHistory). Default displays the list of all."
        )]
        [ValidateSet("events", "alertsHistory")]
        [string]$category,
        [Parameter(
            HelpMessage = "The maximum number of events to return."
        )]
        [ValidateRange(1, 1000000)]
        [int]$limitTo,
        [Parameter(
            HelpMessage = "The earliest timestamp of an event to return, in RFC 3339 standard ('1970-01-01T00:00:00Z'). Default is one year ago."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$startDate,
        [Parameter(
            HelpMessage = "The latest timestamp of an event to return, in RFC 3339 standard ('1970-01-01T00:00:00Z'). Default is the present time."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$endDate
    )
    $uri = "monitoring/events"

    if ( $PSBoundParameters.Keys.Count -gt 0 ) {
        $filterString = Get-ZertoApiFilter -filterTable $PSBoundParameters
        $uri = "{0}{1}" -f $uri, $filterString
    }

    Invoke-ZARestRequest -uri $uri
}
