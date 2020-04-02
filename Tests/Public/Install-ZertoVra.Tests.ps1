#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    Context "$global:function::Parameter Unit Tests" {
        It "$global:function should have exactly 24 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 24
        }

        $ParameterTestCases = @(
            @{ParameterName = 'hostName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'datastoreName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'networkName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'Dhcp'; Type = 'Switch'; Mandatory = $true; Validation = $null }
            @{ParameterName = 'vraIpAddress'; Type = 'String'; Mandatory = $true; Validation = 'IpAddr' }
            @{ParameterName = 'subnetMask'; Type = 'String'; Mandatory = $true; Validation = 'IpAddr' }
            @{ParameterName = 'defaultGateway'; Type = 'String'; Mandatory = $true; Validation = 'IpAddr' }
            @{ParameterName = 'UseRootCredential'; Type = 'Switch'; Mandatory = $true; Validation = $null }
            @{ParameterName = 'HostRootPassword'; Type = 'SecureString'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
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

                'IpAddr' {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.Where{ $_ -is [ValidateScript] }.Count | Should -Be 1
                    $attrs.Where{ $_ -is [ValidateScript] }.ScriptBlock | Should -Match '\$_ \-match \[IPAddress\]\$_'
                }

                $null {
                    $attrs = (Get-Command $global:function).Parameters[$ParameterName].Attributes
                    $attrs.TypeId.Count | Should -Be 3
                }
            }
        }
    }

    Context "$global:function::Parameter Functional Tests" {

    }
}

Remove-Variable -Name here -Scope Global
Remove-Variable -Name function -Scope Global
