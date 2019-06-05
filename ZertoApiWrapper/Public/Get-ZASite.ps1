<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZASite {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "The ZORG identifier by which to filter site list. If the ZORG identifier is omitted, a list of all sites is retrieved."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zOrgIdentifier
    )
    $uri = "monitoring/sites"
    if ( -not [String]::IsNullorEmpty($zOrgIdentifier) ) {
        $filterTable = @{"zOrgIdentifier" = $zOrgIdentifier }
        $filterString = Get-ZertoApiFilter -filterTable $filterTable
        $uri = "{0}{1}" -f $uri, $filterString
    }
    Invoke-ZARestRequest -uri $uri
}
