#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 17 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 17
        }

        $ParameterTestCases = @(
            @{ParameterName = 'siteIdentifier'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vmIdentifier'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'recoveryType'; Type = 'String'; Mandatory = $true; Validation = 'Set' }
            @{ParameterName = 'desiredJournalHistory'; Type = 'Int'; Mandatory = $false; Validation = 'Range' }
            @{ParameterName = 'startDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'endDate'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
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

                'Set' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateSet] }.Count | Should -Be 1
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
