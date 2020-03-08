<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAPlannerSite {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The site identifier(s) for which to return detailed information."
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$siteIdentifier
    )
    $uri = "planner/sites"
    if ( -not [String]::IsNullorEmpty($siteIdentifier) ) {
        $entry = foreach ($id in $siteIdentifier) {
            "{0}/{1}" -f $uri, $id
        }
    } else {
        $entry = $uri
    }
    foreach ($uri in $entry) {
        Invoke-ZARestRequest -uri $uri
    }
}
