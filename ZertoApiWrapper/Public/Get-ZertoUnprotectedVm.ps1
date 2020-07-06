<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoUnprotectedVm {
    [cmdletbinding()]
    param()
    $uri = "virtualizationsites/{0}/vms" -f (Get-ZertoLocalSite).siteIdentifier
    Invoke-ZertoRestRequest -uri $uri
}
