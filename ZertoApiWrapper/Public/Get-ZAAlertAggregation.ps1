<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAAlertAggeration {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the alert count. If the ZORG identifier is omitted, retrieves all alerts sorted by entity and by type."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier
    )
    $uri = "monitoring/alerts"
    if ( -not [String]::IsNullorEmpty($zOrgIdentifier) ) {
        $filterTable = @{"zOrgIdentifier" = $zOrgIdentifier }
        $filterString = Get-ZertoApiFilter -filterTable $filterTable
        $uri = "{0}{1}&format=aggregations" -f $uri, $filterString
    } else {
        $uri = "{0}?format=aggregations" -f $uri
    }
    Invoke-ZARestRequest -uri $uri
}
