function Get-ZALicense {
    $uri = "licenses"
    Invoke-ZARestRequest -uri $uri
}