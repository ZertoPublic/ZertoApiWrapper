function Get-ZertoLicense {
    [cmdletbinding()]
    $uri = "license"
    Invoke-ZertoRestRequest -uri $uri
}
