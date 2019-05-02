<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoUnprotectedVm {
    [cmdletbinding()]
    param()
    $uri = "virtualizationsites/{0}/vms" -f $script:zvmLocalInfo.siteidentifier
    Invoke-ZertoRestRequest -uri $uri
}
