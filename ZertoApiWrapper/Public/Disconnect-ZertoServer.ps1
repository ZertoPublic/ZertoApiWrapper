function Disconnect-ZertoServer {
    [cmdletbinding()]
    $uri = "session"
    Invoke-ZertoRestRequest -uri $uri -method DELETE
    Remove-Variable -Name zvmServer -Scope Script
    Remove-Variable -Name zvmPort -Scope Script
    Remove-Variable -Name zvmLastAction -Scope Script
    Remove-Variable -Name zvmHeaders -Scope Script
    Remove-Variable -Name zvmLocalInfo -Scope Script
}
