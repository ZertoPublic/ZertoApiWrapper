<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZASiteTopology {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter sites topology list. If the ZORG identifier is omitted, information related to all sites topology is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier
    )
    $uri = "monitoring/sites"
    if ( -not [String]::IsNullorEmpty($zOrgIdentifier) ) {
        $filterTable = @{"zOrgIdentifier" = $zOrgIdentifier }
        $filterString = Get-ZertoApiFilter -filterTable $filterTable
        $uri = "{0}{1}&format=topology" -f $uri, $filterString
    } else {
        $uri = "{0}?format=topology" -f $uri
    }
    Invoke-ZARestRequest -uri $uri
}
