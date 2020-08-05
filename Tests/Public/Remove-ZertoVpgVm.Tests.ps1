#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -Leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$global:function::Parameter Unit Tests" {

        It "$global:function should have exactly 15 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 15
        }

        $ParameterTestCases = @(
            @{ParameterName = 'Vm'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'VpgName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory, $Validation)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        It "<ParameterName> parameter has correct validation setting"  -TestCases $ParameterTestCases {
            param($ParameterName, $Validation)
            Switch ($Validation) {
                'NotNullOrEmpty' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
                }

                default {
                    $true | Should -Be $false -Because "No Validation Selected. Review test cases"
                }
            }
        }

        It "Supports 'SupportsShouldProcess'" {
            Get-Command $global:function | Should -HaveParameter WhatIf
            Get-Command $global:function | Should -HaveParameter Confirm
            $script:ScriptBlock | Should -Match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -Match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "Add-ZertoPeerSite::Functional Unit Tests" {
    }
}
Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
