<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZAzOrg {
    [cmdletbinding()]
    param()
    $uri = "monitoring/zorgs"
    Invoke-ZARestRequest -uri $uri
}