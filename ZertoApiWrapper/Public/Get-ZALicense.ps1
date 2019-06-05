<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZALicense {
    [cmdletbinding()]
    param()
    $uri = "licenses"
    Invoke-ZARestRequest -uri $uri
}