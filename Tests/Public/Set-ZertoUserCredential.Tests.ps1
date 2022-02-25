#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    InModuleScope -ModuleName ZertoApiWrapper {

        Context "$global:function::Parameter Unit Tests" {

            BeforeAll {
                $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
            }

            It "$global:function should have exactly 14 parameters defined" {
                (Get-Command $global:function).Parameters.Count | Should -Be 14
            }

            $ParameterTestCases = @(
                @{ParameterName = 'UserCredential'; Type = 'pscredential'; Mandatory = $true }
            )

            It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
                param($ParameterName, $Type, $Mandatory, $Validation)
                Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
            }

            It "Supports 'SupportsShouldProcess'" {
                Get-Command $global:function | Should -HaveParameter WhatIf
                Get-Command $global:function | Should -HaveParameter Confirm
                $script:ScriptBlock | Should -match 'SupportsShouldProcess'
                $script:ScriptBlock | Should -match '\$PSCmdlet\.ShouldProcess\(.+\)'
            }
        }

        Context "$global:function::Parameter Functional Tests" {

        }
    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
