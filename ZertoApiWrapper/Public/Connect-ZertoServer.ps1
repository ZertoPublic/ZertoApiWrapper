function Connect-ZertoServer {
    [cmdletbinding(
        SupportsShouldProcess = $false
    )]
    param(
        [Parameter(
            Mandatory = $true,
            HelpMessage = "IP address or FQDN of your Zerto Management Server"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$zertoServer,
        [Parameter( HelpMessage = "Zerto Virtual Manager management port. Default value is 9669." )]
        [string]$zertoPort = "9669",
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Valid credentials to connect to the Zerto Management Server"
        )]
        [System.Management.Automation.PSCredential]
        $credential
    )
    Set-Variable -Name zvmServer -Scope Script -Value $zertoServer
    Set-Variable -Name zvmPort -Scope Script -Value $zertoPort
    Set-Variable -Name zvmLastAction -Scope Script -Value $(get-date).Ticks
    # $zertoConnectionInformation = @{"zertoServer" = $zertoServer; "zertoPort" = $zertoPort; "LastAction" = $(get-date).Ticks}
    # Set-Item Env:zertoConnectionInformation -Value ($zertoConnectionInformation | ConvertTo-Json -Compress)
    $body = '{"AuthenticationMethod": "1"}'
    $uri = "session/add"
    $results = Invoke-ZertoRestRequest -uri $uri -credential $credential -returnHeaders -body $body -method POST
    $zertoAuthorizationHeaders = @{"x-zerto-session" = $results.Headers['x-zerto-session'][0].ToString(); "Accept" = "application/json"}
    Set-Variable -Name zvmHeaders -Scope Script -Value $zertoAuthorizationHeaders
    # Set-Item Env:zertoAuthorizationHeaders -Value ($zertoAuthorizationHeaders | ConvertTo-Json -Compress)
    Set-Variable -Name zvmLocalInfo -Scope Script -Value (Get-ZertoLocalSite)
    # Set-Item Env:zertoLocalSiteInfo -Value ($zertoLocalSiteInfo | ConvertTo-Json -Compress)
    return $zertoAuthorizationHeaders
}
