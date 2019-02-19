$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. ../$sut
. ../Invoke-ZertoRestRequest.ps1
. ../Disconnect-ZertoServer.ps1

$credential = Import-Clixml -Path C:\ZertoScripts\Creds.xml
$zertoServer = "192.168.222.20"
$zertoPort = "9669"

Describe "Connect-ZertoServer" {
    it "should exist" {
        "../Invoke-ZertoRestRequest.ps1" | should exist
    }
    it "has a function called Connect-ZertoServer" {
        get-command Connect-ZertoServer | should be $true
    }
    Connect-ZertoServer -zertoServer $zertoServer -zertoPort $zertoPort -credential $credential
    it "set an Env variable called zertoConnectionInformation" {
        Test-Path Env:/zertoConnectionInformation | should be $true
    }
    it "set an Env variable called zertoAuthorizationHeaders" {
        Test-Path Env:/zertoAuthorizationHeaders | should be $true
    }
    Disconnect-ZertoServer
}
