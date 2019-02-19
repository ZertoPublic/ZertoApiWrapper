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
        [string]$zertoPort = "9669",
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Valid credentials to connect to the Zerto Management Server"
        )]
        [System.Management.Automation.PSCredential]
        $credential
    )
    $zertoConnectionInformation = @{"zertoServer" = $zertoServer; "zertoPort" = $zertoPort; "LastAction" = $(get-date).Ticks}
    Set-Item Env:zertoConnectionInformation -Value ($zertoConnectionInformation | convertto-json -Compress)
    $body = '{"AuthenticationMethod": "1"}'
    $uri = "session/add"
    $results = Invoke-ZertoRestRequest -uri $uri -credential $credential -returnHeaders -body $body -method POST
    $zertoAuthorizationHeaders = @{"x-zerto-session" = $results.Headers['x-zerto-session'][0].ToString(); "Accept" = "application/json"}
    Set-Item Env:zertoAuthorizationHeaders -Value ($zertoAuthorizationHeaders | convertto-json -Compress)
    return $zertoAuthorizationHeaders
}
