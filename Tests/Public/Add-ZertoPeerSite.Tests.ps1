#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -Leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$global:function::Parameter Unit Tests" {

        It "$global:function should have exactly 16 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 16
        }

        $ParameterTestCases = @(
            @{ParameterName = 'targetHost'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'targetPort'; Type = 'Int32'; Mandatory = $false; Validation = 'Range' }
            @{ParameterName = 'token'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory, $Validation)
            Get-Command $global:function | Should -HaveParameter $ParameterName -Mandatory:$Mandatory -Type $Type
        }

        It "<ParameterName> parameter has correct validation setting"  -TestCases $ParameterTestCases {
            param($ParameterName, $Validation)
            Switch ($Validation) {
                'Range' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateRange] }.Count | Should -Be 1
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

        It "targetPort Parameter should have a default value of 9081" {
            Get-Command $global:function | Should -HaveParameter targetPort -DefaultValue 9081
        }

        It "targetPort Parameter should have a Min value of 1024" {
            (Get-Command $global:function).Parameters['targetPort'].Attributes.Where{ $_ -is [ValidateRange] }.MinRange | Should -Be 1024
        }

        It "targetPort Parameter should have a Max value of 65535" {
            (Get-Command $global:function).Parameters['targetPort'].Attributes.Where{ $_ -is [ValidateRange] }.MaxRange | Should -Be 65535
        }

        It "Supports 'SupportsShouldProcess'" {
            Get-Command $global:function | Should -HaveParameter WhatIf
            Get-Command $global:function | Should -HaveParameter Confirm
            $script:ScriptBlock | Should -Match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -Match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "Add-ZertoPeerSite::Functional Unit Tests" {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
            return (Get-Content "$global:here\Mocks\TaskId.txt")
        }

        It "Returns a string value when no Token Passed" {
            $results = Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort '9081'
            $results | Should -Not -BeNullOrEmpty
            $results | Should -BeOfType "String"
            $results | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

        It "Returns a string value when a Token is passed" {
            $results = Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort '9081' -token "NotARealTokenString"
            $results | Should -Not -BeNullOrEmpty
            $results | Should -BeOfType "String"
            $results | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

        It "Does not return a taskId if '-whatif' is used" {
            $results = Add-ZertoPeerSite -targetHost '192.168.1.100' -targetPort '9081' -WhatIf
            $results | Should -BeNullOrEmpty
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -Exactly 2
    }
}
Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
