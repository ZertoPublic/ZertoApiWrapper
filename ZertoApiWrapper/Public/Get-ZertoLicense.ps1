<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoLicense {
    [cmdletbinding()]
    $uri = "license"
    Invoke-ZertoRestRequest -uri $uri
}
