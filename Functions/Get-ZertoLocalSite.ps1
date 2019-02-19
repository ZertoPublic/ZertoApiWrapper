function Get-ZertoLocalSite {
    [cmdletbinding()]
    param(
        [switch]$pairingstatuses
    )
    $uri = "localsite"
    if ($pairingstatuses) {
        $uri = "/{0}/pairingstatuses" -f $uri
    }
    Invoke-ZertoRestRequest -uri $uri
}
