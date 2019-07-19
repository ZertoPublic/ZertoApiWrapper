function Invoke-ZARestRequest {
    [cmdletbinding()]
    param(
        # Parameter help description
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$uri,
        [ValidateSet("GET", "PUT", "POST", "DELETE")]
        [string]$method = "GET",
        [ValidateNotNullOrEmpty()]
        [string]$body,
        [ValidateNotNullOrEmpty()]
        [string]$contentType = "application/json"
    )

    # Check to see if the required variables are present and currently valid
    if ( -not ((Test-Path variable:script:zaLastActionTime) -and (Test-Path variable:script:zaHeaders)) ) {
        Throw "Zerto Analytics Connection does not Exist. Please run Connect-ZertoAnalytics first to establish a connection"
    } elseif ( (Test-Path variable:script:zaHeaders) -and $([datetime]$script:zaLastActionTime).addMinutes(60) -lt $(get-date) ) {
        Throw "Authorization Token has Expired. Please re-authorize to the Zerto Analytics Portal"
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
