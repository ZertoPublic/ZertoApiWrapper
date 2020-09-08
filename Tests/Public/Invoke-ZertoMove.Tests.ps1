#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 21 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 21
        }

        $ParameterTestCases = @(
            @{ParameterName = 'vpgIdentifier'; Type = 'Guid[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'vpgName'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'commitPolicy'; Type = 'String'; Mandatory = $false; Validation = 'Set' }
            @{ParameterName = 'commitPolicyTimeout'; Type = 'Int'; Mandatory = $false; Validation = 'Range' }
            @{ParameterName = 'forceShutdown'; Type = 'Switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'disableReverseProtection'; Type = 'Switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'keepSourceVms'; Type = 'Switch'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'ContinueOnPreScriptFailure'; Type = 'Switch'; Mandatory = $false; Validation = $null }
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

                'Set' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateSet] }.Count | Should -Be 1
                }

                'Range' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateRange] }.Count | Should -Be 1
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

        It "Commit Policy Only Accecpts 'RollBack', 'Commit', or 'None'" {
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -HaveCount 3
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'RollBack'
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'Commit'
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'None'
        }

        It "Commit Policy Timeout should have a minimum value of 300 and max value of 86400" {
            (Get-Command $global:function).Parameters['commitPolicyTimeout'].Attributes.Where{ $_ -is [ValidateRange] }.MinRange | Should -Be 300
            (Get-Command $global:function).Parameters['commitPolicyTimeout'].Attributes.Where{ $_ -is [ValidateRange] }.MaxRange | Should -Be 86400
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
