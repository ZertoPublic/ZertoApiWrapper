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
    Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
        return "3b687246-ac63-40da-9a59-b99863769eb0.928a122b-1763-4664-ad37-cc00bb883f2f"
    }
    Mock -ModuleName ZertoApiWrapper -CommandName get-zertovpg {
        return @{vpgIdentifier = "dddf2fa8-79e2-4e4f-a83b-f66676afea64"}
    }
    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    it "should return a string" {
        $results = Checkpoint-ZertoVpg -vpgName "MyVpg" -checkpointName "My Checkpoint Name"
        $results | should -not -BeNullOrEmpty
        $results | should -BeOfType "String"
        $results | should -BeExactly "3b687246-ac63-40da-9a59-b99863769eb0.928a122b-1763-4664-ad37-cc00bb883f2f"
    }

    it "should require a tag name" {
        {Checkpoint-ZertoVpg -vpgName "MyVpg" -checkpointName ""} | Should -Throw
    }

    it "should NOT support '-WhatIf'" {
        {Checkpoint-ZertoVpg -vpgName "MyVpg" -checkpointName "Checkers" -whatif} | Should -Throw
    }

    Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest
    Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpg
}