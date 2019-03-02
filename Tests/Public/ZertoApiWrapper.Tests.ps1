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

Describe "File Tests" {
    $commands = Get-Command -Module ZertoApiWrapper | Select-Object -ExpandProperty Name
    foreach ($command in $commands) {
        $path = "{0}/{1}.ps1" -f $filePath, $command
        it "$command is backed by a file with the same name" {
            $path | should exist
        }
    }
}