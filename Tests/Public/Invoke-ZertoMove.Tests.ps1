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

        it "has a mandatory string parameter for the vpgName" {
            Get-Command $file.BaseName | Should -HaveParameter vpgName
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Type string[]
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Mandatory
        }

        it "has a non-mandatory string parameter for commitPolicy" {
            Get-Command $file.BaseName | Should -HaveParameter commitPolicy
            Get-Command $file.BaseName | Should -HaveParameter commitPolicy -Type string
        }

        it "CommitPolicy only accecpts 'Rollback', 'Commit', or 'None'" {
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicy "Rollbackk" } | Should -Throw
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicy "" } | Should -Throw
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicy $null } | Should -Throw
        }

        it "has a non-mandatory int parameter for commitPolicyTimeout" {
            Get-Command $file.BaseName | Should -HaveParameter commitPolicyTimeout
            Get-Command $file.BaseName | Should -HaveParameter commitPolicyTimeout -Type Int
        }

        it "Commit Policy Timeout will only accecpt an int value between 5 minutes and 24 Hours" {
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicyTimeout 150 } | Should -Throw
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicyTimeout 15000000 } | Should -Throw
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicyTimeout -1350 } | Should -Throw
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicyTimeout $null } | Should -Throw
            { Invoke-ZertoMove -vpgName "MyVpg" -commitPolicyTimeout "" } | Should -Throw
        }

        it "has a non-mandatory switch parameter for forceShutdown" {
            Get-Command $file.BaseName | Should -HaveParameter forceShutdown
            Get-Command $file.BaseName | Should -HaveParameter forceShutdown -Type Switch
        }

        it "has a mandatory switch parameter for disableReverseProtection" {
            Get-Command $file.BaseName | Should -HaveParameter disableReverseProtection
            Get-Command $file.BaseName | Should -HaveParameter disableReverseProtection -Type Switch
            Get-Command $file.BaseName | Should -HaveParameter disableReverseProtection -Mandatory
        }

        it "has a non-mandatory switch parameter for keepSourceVms" {
            Get-Command $file.BaseName | Should -HaveParameter keepSourceVms
            Get-Command $file.BaseName | Should -HaveParameter keepSourceVms -Type Switch
            Get-Command $file.BaseName | Should -HaveParameter keepSourceVms -Mandatory
        }

        it "has a non-mandatory switch parameter for ContinueOnPreScriptFailure" {
            Get-Command $file.BaseName | Should -HaveParameter ContinueOnPreScriptFailure
            Get-Command $file.BaseName | Should -HaveParameter ContinueOnPreScriptFailure -Type Switch
        }
    }
}