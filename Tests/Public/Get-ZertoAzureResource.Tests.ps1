#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -Leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$global:function::Parameter Unit Tests" {

        It "$global:function should have exactly 17 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 17
        }

        $ParameterTestCases = @(
            @{ParameterName = 'siteName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'SiteIdentifier'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'SecurityGroup'; Type = 'Switch'; Mandatory = $true; Validation = 'None' }
            @{ParameterName = 'Subnet'; Type = 'Switch'; Mandatory = $true; Validation = 'None' }
            @{ParameterName = 'Network'; Type = 'Switch'; Mandatory = $true; Validation = 'None' }
            @{ParameterName = 'VmInstanceType'; Type = 'Switch'; Mandatory = $true; Validation = 'None' }

        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory, $Validation)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        It "<ParameterName> parameter has correct validation setting"  -TestCases $ParameterTestCases {
            param($ParameterName, $Validation)
            Switch ($Validation) {
                'None' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Count | Should -Be 3
                }

                'NotNullOrEmpty' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateNotNullOrEmpty] }.Count | Should -Be 1
                }

                default {
                    $true | Should -Be $false -Because "No Validation Selected. Review test cases"
                }
            }
        }
    }

    Context "$global:function::Functional Unit Tests" {

    }
}
Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
