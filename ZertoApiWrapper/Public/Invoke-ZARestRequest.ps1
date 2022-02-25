<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Invoke-ZARestRequest {
    [cmdletbinding()]
    param(
        # Parameter help description
        [Parameter(
            Mandatory,
            Helpmessage = "URI endpoint to be utilized. When submitting the URI, only the endpoint needs to be submitted. Please review the help documentation for examples."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$uri,
        [Parameter(
            Helpmessage = "API method to be used. GET, PUT, POST, or DELETE. Refer to documentation for the API endpoint to ensure the correct method is being used. If unspecified, defaults to GET"
        )]
        [ValidateSet("GET", "PUT", "POST", "DELETE")]
        [string]$method = "GET",
        [Parameter(
            Helpmessage = "Body to be submitted to the REST API endpoint. This needs to be submitted in JSON format"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$body

    )
    # While the API can use XML or JSON, this module is built on JSON functionality. Currently forcing all
    # content types and language to JSON.
    [string]$contentType = "application/json"

    # Check to see if the required variables are present and currently valid
    if ( -not ((Test-Path variable:script:zaLastActionTime) -and (Test-Path variable:script:zaHeaders)) ) {
        Throw "Zerto Analytics Connection does not Exist. Please run Connect-ZertoAnalytics first to establish a connection"
    } elseif ( (Test-Path variable:script:zaHeaders) -and $([datetime]$script:zaLastActionTime).addMinutes(60) -lt $(Get-Date) ) {
        Throw "Authorization Token has Expired. Please re-authorize to the Zerto Analytics Portal"
    } else {
        # Update the last action time and submit the request based on PS Version.
        Set-Variable -Name zaLastActionTime -Scope Script -Value $(Get-Date).Ticks
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
