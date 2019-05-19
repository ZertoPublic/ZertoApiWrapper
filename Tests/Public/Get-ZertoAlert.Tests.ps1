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

        it "Has a mandatory string parameter for the Alert identifier" {
            Get-Command $file.BaseName | Should -HaveParameter alertId
            Get-Command $file.BaseName | Should -HaveParameter alertId -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter alertId -Type String[]
        }

        it "Has a non-mandatory switch parameter for the entities" {
            Get-Command $file.BaseName | Should -HaveParameter entities
            Get-Command $file.BaseName | Should -HaveParameter entities -Type switch
        }

        it "Has a non-mandatory switch parameter for the helpIdentifiers" {
            Get-Command $file.BaseName | Should -HaveParameter helpIdentifiers
            Get-Command $file.BaseName | Should -HaveParameter helpIdentifiers -Type switch
        }

        it "Has a non-mandatory switch parameter for the levels" {
            Get-Command $file.BaseName | Should -HaveParameter levels
            Get-Command $file.BaseName | Should -HaveParameter levels -Type switch
        }

        it "Has a non-mandatory string parameter for the startDate" {
            Get-Command $file.BaseName | Should -HaveParameter startDate
            Get-Command $file.BaseName | Should -HaveParameter startDate -Type string
        }

        it "Has a non-mandatory string parameter for the endDate" {
            Get-Command $file.BaseName | Should -HaveParameter endDate
            Get-Command $file.BaseName | Should -HaveParameter endDate -Type string
        }

        it "Has a non-mandatory string parameter for the vpgIdentifier" {
            Get-Command $file.BaseName | Should -HaveParameter vpgIdentifier
            Get-Command $file.BaseName | Should -HaveParameter vpgIdentifier -Type string
        }

        it "Has a non-mandatory string parameter for the siteIdentifier" {
            Get-Command $file.BaseName | Should -HaveParameter siteIdentifier
            Get-Command $file.BaseName | Should -HaveParameter siteIdentifier -Type string
        }

        it "Has a non-mandatory string parameter for the zorgIdentifier" {
            Get-Command $file.BaseName | Should -HaveParameter zorgIdentifier
            Get-Command $file.BaseName | Should -HaveParameter zorgIdentifier -Type string
        }

        it "Has a non-mandatory string parameter for the level" {
            Get-Command $file.BaseName | Should -HaveParameter level
            Get-Command $file.BaseName | Should -HaveParameter level -Type string
        }

        it "Has a non-mandatory string parameter for the helpIdentifier" {
            Get-Command $file.BaseName | Should -HaveParameter helpIdentifier
            Get-Command $file.BaseName | Should -HaveParameter helpIdentifier -Type string
        }

        it "Has a non-mandatory bool parameter for the isDismissed" {
            Get-Command $file.BaseName | Should -HaveParameter isDismissed
            Get-Command $file.BaseName | Should -HaveParameter isDismissed -Type bool
        }
    }
}

