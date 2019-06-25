function Invoke-ZARestRequest {
    [cmdletbinding()]
    param(
        [string]$uri,
        [string]$method = "GET",
        [string]$body,
        [string]$contentType = "application/json"
    )

    # Check to see if the required variables are present and currently valid
    if ( -not ((Test-Path variable:script:zaLastActionTime) -and (Test-Path variable:script:zaHeaders)) ) {
        Write-Error -Message "Zerto Analytics Connection does not Exist. Please run Connect-ZertoAnalytics first to establish a connection"
        break
    } elseif ( (Test-Path variable:script:zaHeaders) -and $([datetime]$script:zaLastActionTime).addMinutes(60) -lt $(get-date) ) {
        Write-Error -Message "Authorization Token has Expired. Please re-authorize to the Zerto Analytics Portal"
        break
    } else {
        # Update the last action time and submit the request based on PS Version.
        Set-Variable -Name zaLastActionTime -Scope Script -Value $(Get-date).Ticks
        $submittedUri = "https://analytics.api.zerto.com/v2/{0}" -f $uri
        if ($PSVersionTable.PSVersion.Major -ge 6) {
            Invoke-RestMethod -Uri $submittedUri -Method $method -Body $body -Headers $Script:zaHeaders -ContentType $contentType -TimeoutSec 100
        } else {
            # With PS 5, you cannot ship a $null body, check for $body variable and select correct Invoke request.
            if ([String]::IsNullOrEmpty($body)) {
                Invoke-RestMethod -Uri $submittedUri -Method $method -Headers $Script:zaHeaders -ContentType $contentType -TimeoutSec 100
            } else {
                Invoke-RestMethod -Uri $submittedUri -Method $method -Headers $Script:zaHeaders -ContentType $contentType -TimeoutSec 100 -Body $body
            }
        }
    }
}
