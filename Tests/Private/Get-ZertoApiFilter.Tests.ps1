#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    InModuleScope -ModuleName ZertoApiWrapper {
        Context "$global:function::Parameter Unit Tests" {
            It "has a mandatory hashtable parameter for the filterTable" {
                Get-Command $global:function | Should -HaveParameter filterTable -Mandatory -Type Hashtable
            }

            It "FilterTable should not accecpt a Null or Empty parameter" {
                { Get-ZertoApiFilter -filtertable (@{ }) } | Should Throw
                { Get-ZertoApiFilter -filtertable "" } | Should Throw
                { Get-ZertoApiFilter -filtertable $null } | Should Throw
            }

            It "should have an Output type of String" {
                (Get-Command $global:function).OutputType.Name | Should -Match "String"
            }
        }

        Context "$global:function::Function Unit Tests" {
            BeforeAll {
                $singleBoolItemTest = @{"BoolItem" = $True }
                $oneItemTest = @{ OneItem = "Test" }
                $twoItemTest = @{
                    OneItem    = "Test"
                    SecondItem = "Yours"
                }
                $commonParamTest = @{
                    Debug               = $True
                    ErrorAction         = "Stop"
                    ErrorVariable       = "ErrVar"
                    InformationAction   = "Continue"
                    InformationVariable = "InfoVar"
                    OutVariable         = "OutVar"
                    OutBuffer           = "OutBuff"
                    PipelineVariable    = "PipeVar"
                    Verbose             = $false
                    WarningAction       = "SilentlyContinue"
                    WarningVariable     = "WarnVar"
                    WhatIf              = $True
                    Confirm             = $false
                    OneItem             = "Test"
                }
            }

            It "converts bool to text" {
                Get-ZertoApiFilter -filtertable $singleBoolItemTest | Should -Be "?BoolItem=True"
            }

            It "one item test" {
                Get-ZertoApiFilter -filtertable $oneItemTest | Should -Be "?OneItem=Test"
            }

            It "should ignore CommonParameters" {
                Get-ZertoApiFilter -filtertable $commonParamTest | Should -Be "?OneItem=Test"
            }

            It "should process a filter table with more than one item" {
                $returnString = Get-ZertoApiFilter -filtertable $twoItemTest
                $returnString | Should -match "^\?"
                $returnString | Should -match "&"
                $returnString | Should -match "OneItem=Test"
                $returnString | Should -match "SecondItem=Yours"
            }
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
