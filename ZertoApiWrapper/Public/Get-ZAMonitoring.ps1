<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAMonitoring {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter the user's statistics for a single account. If the ZORG identifier is omitted, statistics related to all sites, for a single account, is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier
    )
    $uri = "monitoring/"
    if ( -not [String]::IsNullorEmpty($zOrgIdentifier) ){
        $filterTable = @{"zOrgIdentifier" = $zOrgIdentifier}
        $filterString = Get-ZertoApiFilter -filterTable $filterTable
        $uri = "{0}{1}" -f $uri, $filterString
    }
    Invoke-ZARestRequest -uri $uri
}