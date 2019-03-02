<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Disconnect-ZertoServer {
    [cmdletbinding()]
    $uri = "session"

    # Delete API Authorization
    Invoke-ZertoRestRequest -uri $uri -method DELETE

    # Remove all variables used
    Remove-Variable -Name zvmServer -Scope Script
    Remove-Variable -Name zvmPort -Scope Script
    Remove-Variable -Name zvmLastAction -Scope Script
    Remove-Variable -Name zvmHeaders -Scope Script
    Remove-Variable -Name zvmLocalInfo -Scope Script
}
