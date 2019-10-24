#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        it "$global:function should have exactly 16 parameters defined" {
            (get-command $global:function).Parameters.Count | Should -Be 16
        }

        $ParameterTestCases = @(
            @{ParameterName = 'hostName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty'; ParameterSet = @('hostName') }
            @{ParameterName = 'vraName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' ; ParameterSet = @('vraName') }
            @{ParameterName = 'vraIdentifier'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' ; ParameterSet = @('vraIdentifier') }
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

                $null {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.TypeId.Count | Should -Be 2
                }
            }
        }

        It "<ParameterName> parameter is part of the correct ParameterSet(s)" -TestCases $ParameterTestCases {
            param($ParameterName, $ParameterSet)
            $commandParameterSets = (Get-Command $global:function).Parameters[$ParameterName].ParameterSets
            foreach ($Set in $ParameterSet) {
                $commandParameterSets.ContainsKey($Set) | Should -BeTrue
            }
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
