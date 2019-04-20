<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoLicense {
    [cmdletbinding()]
    param()
    $uri = "license"
    Invoke-ZertoRestRequest -uri $uri
}
