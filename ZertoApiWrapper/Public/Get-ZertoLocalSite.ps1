<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoLocalSite {
    [cmdletbinding()]
    param(
        [Parameter(
            HelpMessage = "Switch to return possible paiting statuses."
        )]
        [switch]$pairingstatuses
    )
    $uri = "localsite"
    if ($pairingstatuses) {
        $uri = "/{0}/pairingstatuses" -f $uri
    }
    Invoke-ZertoRestRequest -uri $uri
}
