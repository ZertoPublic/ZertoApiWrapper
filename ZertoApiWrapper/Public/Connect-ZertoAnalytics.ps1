<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml
#>
function Connect-ZertoAnalytics {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory,
            HelpMessage = "PSCredential Object containing username and password authorized for the Zerto Analytics site",
            Position = 0
        )]
        [System.Management.Automation.PSCredential]$credential
    )

    $uri = "auth/token"
    Set-Variable -Name zaHeaders -Scope Script -Value @{"Accept" = "application/json" }
    Set-Variable -Name zaLastActionTime -Scope Script -Value $(Get-date).Ticks
    $body = @{"username" = $credential.UserName; "password" = $credential.GetNetworkCredential().password }
    $result = Invoke-ZARestRequest -Uri $uri -body $($body | ConvertTo-Json) -Method POST
    $Script:zaHeaders["Authorization"] = "Bearer $($result.Token)"
    $Script:zaHeaders
}
