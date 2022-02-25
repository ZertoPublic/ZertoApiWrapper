#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 15 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 15
        }

        $ParameterTestCases = @(
            @{ParameterName = 'vpgIdentifier'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'startDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'endDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'Interval'; Type = 'Int32'; Mandatory = $false; Validation = 'Range' }
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

                'Range' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateRange] }.Count | Should -Be 1
                }

                default {
                    $true | Should -Be $false -Because "No Validation Selected. Review test cases"
                }
            }
        }

        It "Interval Parameter should have a Min value of 60" {
            (Get-Command $global:function).Parameters['Interval'].Attributes.Where{ $_ -is [ValidateRange] }.MinRange | Should -Be 60
        }

        It "Interval Parameter should have a Max value of 2678400" {
            (Get-Command $global:function).Parameters['Interval'].Attributes.Where{ $_ -is [ValidateRange] }.MaxRange | Should -Be 2678400
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
