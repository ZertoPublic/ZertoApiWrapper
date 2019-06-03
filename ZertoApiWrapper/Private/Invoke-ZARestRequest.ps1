function Invoke-ZARestRequest {
    [cmdletbinding()]
    param(
        [string]$uri,
        [string]$method = "GET",
        [string]$body,
        [string]$contentType = "application/json"
    )

    $submittedUri = "https://analytics.api.zerto.com/v2/{0}" -f $uri
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        Invoke-RestMethod -Uri $submittedUri -Method $method -Body $body -Headers $Script:zaHeaders -ContentType $contentType -TimeoutSec 100
    } else {
        if ([String]::IsNullOrEmpty($body)) {
            Invoke-RestMethod -Uri $submittedUri -Method $method -Headers $Script:zaHeaders -ContentType $contentType -TimeoutSec 100
        } else {
            Invoke-RestMethod -Uri $submittedUri -Method $method -Headers $Script:zaHeaders -ContentType $contentType -TimeoutSec 100 -Body $body
        }
    }
}