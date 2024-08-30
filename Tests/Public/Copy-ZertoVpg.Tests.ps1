#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$($global:function)::Parameter Unit Tests" {

        It "$global:function should have exactly 16 parameters defined" {
            (Get-Command $global:function).Parameters.Count | Should -Be 16
        }

        $ParameterTestCases = @(
            @{ParameterName = 'SourceVpgName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'NewVpgName'; Type = 'String'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
            @{ParameterName = 'VMs'; Type = 'String[]'; Mandatory = $true; Validation = 'NotNullOrEmpty' }
	    @{ParameterName = 'StoragePolicyIdentifier'; Type = 'String'; Mandatory = $false; Validation = 'NotNullOrEmpty' }
        )

        It "<ParameterName> parameter is of <Type> type" -TestCases $ParameterTestCases {
            param($ParameterName, $Type, $Mandatory)
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

        It "Supports 'SupportsShouldProcess'" {
            Get-Command $global:function | Should -HaveParameter WhatIf
            Get-Command $global:function | Should -HaveParameter Confirm
            $script:ScriptBlock | Should -match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "$($global:function)::Function Unit Tests" {
        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpg -ParameterFilter {
            $vpgName -eq "MyVpg"
        } {
            return (Get-Content "$global:here\Mocks\GetVpg.json" -Raw | ConvertFrom-Json)
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpg -ParameterFilter {
            $vpgName -eq "NotAVpg"
        } {
            return $null
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoUnprotectedVm {
            return (Get-Content "$global:here\Mocks\UnprotectedVms.json" -Raw | ConvertFrom-Json)
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoProtectedVm {
            return (Get-Content "$global:here\Mocks\ProtectedVms.json" -Raw | ConvertFrom-Json)
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq "vpgSettings/copyVpgSettings"
        } {
            return (Get-Content "$global:here\Mocks\VpgId.txt")
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq "vpgSettings/9607f923-00a7-477b-8b04-26a386214455/vms"
        } {
            return $null
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -ParameterFilter {
            $uri -eq "vpgSettings/9607f923-00a7-477b-8b04-26a386214455"
        } {
            return (Get-Content "$global:here\Mocks\CopyVpgSettings.json" -Raw | ConvertFrom-Json)
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Save-ZertoVpgSetting {
            return (Get-Content "$global:here\Mocks\TaskId.txt")
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Get-Map -ParameterFilter {
            $null -ne $InputObject[0].VpgName
        } {
            @{
                "WindowsBox"    = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-90"
                "CentOS-Test"   = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-88"
                "Application01" = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-35"
                "sql01-test"    = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-73"
                "jenkins"       = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-75"
            }
        } -Verifiable
        Mock -ModuleName ZertoApiWrapper -CommandName Get-Map -ParameterFilter {
            $null -eq $InputObject[0].VpgName
        } {
            @{
                "Win2019Template" = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-79"
                "Ubuntu01"        = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-34"
                "WinTemplate"     = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-25"
                "sql01-prod"      = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-87"
                "nczvm.nc.lab"    = "d809de8e-deb7-45cc-b620-08030a1143e1.vm-30"
            }
        } -Verifiable

        It "Should throw an error when no VPG is found" {
            { Copy-ZertoVpg -SourceVpgName "NotAVpg" -NewVpgName "NewVpg" -VMs 'sql01-prod', 'Ubuntu01' } | Should Throw "Unable to find a VPG with the name:"
        }

        It "Returns a TaskIdentifier when called correctly" {
            Copy-ZertoVpg -SourceVpgName "MyVpg" -NewVpgName "NewVpg" -VMs 'sql01-prod', 'Ubuntu01' | Should -Be "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }

        It "Should warn when VM is not found" {
            $results = Copy-ZertoVpg -SourceVpgName "MyVpg" -NewVpgName "NewVpg" -VMs 'sql01-prod', 'Ubuntu01', 'DoesNotExist' 3>&1
            $results[0].ToString() | Should -Match 'Unable to find VM with Name DoesNotExist. Skipping.'

        }

        Assert-VerifiableMock
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
