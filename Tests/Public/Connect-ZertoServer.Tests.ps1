$moduleFileName = "ZertoApiWrapper.psm1"
$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$fileName = (Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '.Tests.', '.'
$modulePath = $filePath -replace "Public", ""
Import-Module $modulePath\$moduleFileName -Force

$userName = "zerto\build"
$password = ConvertTo-SecureString -String "ZertoBuild" -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential($userName, $password)

# $credential = Import-Clixml -Path C:\ZertoScripts\Creds.xml
$zertoServer = "192.168.1.100"
$zertoPort = "7669"

Describe "Connect-ZertoServer" {
    it "file should exist" {
        "$filePath\$fileName" | should exist
    }
    it "has a function called Connect-ZertoServer" {
        get-command Connect-ZertoServer | should be $true
    }
    $headers = Connect-ZertoServer -zertoServer $zertoServer -zertoPort $zertoPort -credential $credential -returnHeaders
    it "returns a Hashtable with 2 keys" {
        $headers.keys.count | should be 2
    }
    it "return value has a key called 'x-zerto-session'" {
        $headers.ContainsKey('x-zerto-session') | should be $true
    }
    it "return key 'x-zerto-session' value should be a string" {
        $headers['x-zerto-session'].gettype().name | should be "String"
    }
    it "return value has a key called 'accept'" {
        $headers.ContainsKey('accept') | should be $true
    }
    it "return key 'accept' value should be 'application/json'" {
        $headers['accept'] | should be 'application/json'
    }
    Disconnect-ZertoServer
}
