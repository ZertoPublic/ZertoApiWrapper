function Disconnect-ZertoServer {
    [cmdletbinding()]
    $uri = "session"
    Invoke-ZertoRestRequest -uri $uri -method DELETE
    Remove-Item Env:zertoAuthorizationHeaders
    Remove-Item Env:zertoConnectionInformation  
}
