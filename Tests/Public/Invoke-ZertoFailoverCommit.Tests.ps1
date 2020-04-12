#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {

        It "$global:function should have exactly 15 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 15
        }

        $ParameterTestCases = @(
            @{ParameterName = 'vpgName'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'reverseProtection'; Type = 'switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'whatIf'; Type = 'Switch'; Mandatory = $false; Validation = 'ShouldProcess' }
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

                'ShouldProcess' {
                    $scriptBlock = (Get-Command $global:function).ScriptBlock
                    $scriptBlock | Should -match 'SupportsShouldProcess'
                    $scriptBlock | Should -match '\$PSCmdlet\.ShouldProcess\(.+\)'
                }

                $null {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.TypeId.Count | Should -Be 2
                }

                default {
                    $true | Should -Be $false -Because "No Validation Selected. Review test cases"
                }
            }
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
