#Requires -Modules Pester
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace("Tests", "ZertoApiWrapper")
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force

Describe $file.BaseName -Tag 'Unit' {

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    Context "$($file.BaseName)::Parameter Unit Tests" {

        It "Has a mandatory string array parameter for the settings file to import" {
            Get-Command $file.BaseName | Should -HaveParameter settingsFile
            Get-Command $file.BaseName | Should -HaveParameter settingsFile -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter settingsFile -Type String[]
        }

        It "Will not accecpt a Null or Empty string for the settings file" {
            {Import-ZertoVpg -settingsFile $null} | Should -Throw
            {Import-ZertoVpg -settingsFile ""} | Should -Throw
            {Import-ZertoVpg -settingsFile @()} | Should -Throw
        }

    }

    Context "$($file.BaseName)::Function Unit Tests" {

    }
}
