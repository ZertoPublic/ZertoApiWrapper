$moduleName = "ZertoApiWrapper"
$moduleFileName = "ZertoApiWrapper.psm1"
$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$fileName = (Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '.Tests.', '.'
$modulePath = $filePath -replace "Public", ""
$userName = "zerto\build"
$password = ConvertTo-SecureString -String "ZertoBuild" -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential($userName, $password)

# $credential = Import-Clixml -Path C:\ZertoScripts\Creds.xml
$zertoServer = "192.168.1.100"
$zertoPort = "7669"

Import-Module $modulePath\$moduleFileName

Describe "File Tests" {
    Remove-Module $moduleName -Force
    Import-Module $modulePath\$moduleFileName
    $commands = Get-Command -Module $moduleName | Select-Object -ExpandProperty Name
    foreach ($command in $commands) {
        $path = "{0}/{1}.ps1" -f $filePath, $command
        it "$command is backed by a file with the same name" {
            $path | should exist
        }
    }
}

describe "External Help Defination Present" {
    $publicFiles = Get-ChildItem "$filePath" -File
    foreach ($file in $publicFiles) {
        it "External Help File is Defined" {
            Get-Content -Path $file.fullName -First 1 | should be "<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>"
        }
    }
}

Describe "Connection Tests"