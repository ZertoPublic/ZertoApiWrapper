#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        $ParameterTestCases = @(
            @{ParameterName = 'vpgName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'checkpointIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'commitPolicy'; Type = 'String'; Mandatory = $false; Validation = 'Set' }
            @{ParameterName = 'shutdownPolicy'; Type = 'Int'; Mandatory = $false; Validation = 'Set' }
            @{ParameterName = 'timeToWaitBeforeShutdownInSec'; Type = 'Int'; Mandatory = $false; Validation = 'Range' }
            @{ParameterName = 'reverseProtection'; Type = 'bool'; Mandatory = $false; Validation = $null }
            @{ParameterName = 'vmName'; Type = 'String[]'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
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

                'Range' {
                    $scriptBlock = (Get-Command $global:function).ScriptBlock
                    $scriptBlock | Should -match 'SupportsShouldProcess'
                    $scriptBlock | Should -match '\$PSCmdlet\.ShouldProcess\(.+\)'
                }

                $null {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.TypeId.Count | Should -Be 2
                }
            }
        }

        It "Commit Policy Default Value is 'RollBack'" {
            Get-Command $global:function | Should -HaveParameter commitPolicy -DefaultValue "Rollback"
        }

        It "Commit Policy Only Accecpts 'RollBack', 'Commit', or 'None'" {
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -HaveCount 3
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'RollBack'
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'Commit'
            (Get-Command $global:function).Parameters['commitPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 'None'
        }

        It "Shutdown Policy Default Value is '0'" {
            Get-Command $global:function | Should -HaveParameter shutdownPolicy -DefaultValue 0
        }

        It "Shutdown Policy Only Accecpts 'RollBack', 'Commit', or 'None'" {
            (Get-Command $global:function).Parameters['shutdownPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -HaveCount 3
            (Get-Command $global:function).Parameters['shutdownPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 0
            (Get-Command $global:function).Parameters['shutdownPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 1
            (Get-Command $global:function).Parameters['shutdownPolicy'].Attributes.Where{ $_ -is [ValidateSet] }.ValidValues | Should -Contain 2
        }

        it "Time to wait before shutdown in sec should have a default value of 3600" {
            Get-Command $global:function | Should -HaveParameter timeToWaitBeforeShutdownInSec -DefaultValue 3600
        }

        it "Time to wait before shutdown in sec should have a minimum value of 300 and max value of 86400" {
            (Get-Command $global:function).Parameters['timeToWaitBeforeShutdownInSec'].Attributes.Where{ $_ -is [ValidateRange] }.MinRange | Should -Be 300
            (Get-Command $global:function).Parameters['timeToWaitBeforeShutdownInSec'].Attributes.Where{ $_ -is [ValidateRange] }.MaxRange | Should -Be 86400
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
