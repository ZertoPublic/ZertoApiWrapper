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
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Type string
            Get-Command $file.BaseName | Should -HaveParameter vpgName -Mandatory
        }

        it "has a non-mandatory string parameter for the checkpoint" {
            Get-Command $file.BaseName | Should -HaveParameter checkpointIdentifier
            Get-Command $file.BaseName | Should -HaveParameter checkpointIdentifier -Type string
            Get-Command $file.BaseName | Should -HaveParameter checkpointIdentifier -Not -Mandatory
        }

        it "has a non-mandatory string parameter for the commit policy" {
            Get-Command $file.BaseName | Should -HaveParameter commitPolicy
            Get-Command $file.BaseName | Should -HaveParameter commitPolicy -Type string
            Get-Command $file.BaseName | Should -HaveParameter commitPolicy -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter commitPolicy -DefaultValue "Rollback"
        }

        it "has a non-mandatory int parameter for the shutdown policy" {
            Get-Command $file.BaseName | Should -HaveParameter shutdownPolicy
            Get-Command $file.BaseName | Should -HaveParameter shutdownPolicy -Type int
            Get-Command $file.BaseName | Should -HaveParameter shutdownPolicy -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter shutdownPolicy -DefaultValue 0
        }

        it "has a non-mandatory int parameter for the time to wait before force shutdown" {
            Get-Command $file.BaseName | Should -HaveParameter timeToWaitBeforeShutdownInSec
            Get-Command $file.BaseName | Should -HaveParameter timeToWaitBeforeShutdownInSec -Type int
            Get-Command $file.BaseName | Should -HaveParameter timeToWaitBeforeShutdownInSec -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter timeToWaitBeforeShutdownInSec -DefaultValue 3600
        }

        it "has a non-mandatory bool parameter for the reverse protection policy" {
            Get-Command $file.BaseName | Should -HaveParameter reverseProtection
            Get-Command $file.BaseName | Should -HaveParameter reverseProtection -Type bool
            Get-Command $file.BaseName | Should -HaveParameter reverseProtection -Not -Mandatory
        }

        it "has a non-mandatory array string parameter for the named VMs to be failed over" {
            Get-Command $file.BaseName | Should -HaveParameter vmName
            Get-Command $file.BaseName | Should -HaveParameter vmName -Type string[]
            Get-Command $file.BaseName | Should -HaveParameter vmName -Not -Mandatory
        }

        it "Supports 'SupportsShouldProcess'" {
            Get-Command $file.BaseName | Should -HaveParameter WhatIf
            Get-Command $file.BaseName | Should -HaveParameter Confirm
            $file | Should -FileContentMatch 'SupportsShouldProcess'
            $file | Should -FileContentMatch '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "$($file.BaseName)::Function Unit Tests" {
        #TODO
    }
}
