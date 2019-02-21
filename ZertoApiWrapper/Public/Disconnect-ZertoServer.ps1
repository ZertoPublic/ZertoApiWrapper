function Disconnect-ZertoServer {
    [cmdletbinding()]
    $uri = "session"
    Invoke-ZertoRestRequest -uri $uri -method DELETE
    Clear-Variable -Name zvmServer -Scope Script
    Clear-Variable -Name zvmPort -Scope Script
    Clear-Variable -Name zvmLastAction -Scope Script
    Clear-Variable -Name zvmHeaders -Scope Script
    Clear-Variable -Name zvmLocalInfo -Scope Script
}
