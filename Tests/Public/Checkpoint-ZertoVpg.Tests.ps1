#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$script:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $script:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $script:function).ScriptBlock
    }

    Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
        return (Get-Content "$global:here\Mocks\TaskId.txt")
    }
    Mock -ModuleName ZertoApiWrapper -CommandName get-zertovpg -ParameterFilter { $VpgName -eq "MyVpg" } {
        return (Get-Content "$global:here\Mocks\VPGInfo.json" -Raw | ConvertFrom-Json)
    }

    Context "$($script:function)::Parameter Unit Tests" {
        It "Has a parameter for the VpgName that is Mandatory" {
            Get-Command $script:function | Should -HaveParameter vpgName -Mandatory -Type String
        }

        It "Has a parameter for the CheckpointName that is Mandatory" {
            Get-Command $script:function | Should -HaveParameter CheckpointName -Mandatory -Type String
        }

        It "Throws and error when an empty or null checkpointName is specified" {
            { Checkpoint-ZertoVpg -vpgName "MyVpg" -checkpointName "" } | Should -Throw
            { Checkpoint-ZertoVpg -vpgName "MyVpg" -checkpointName $null } | Should -Throw
        }

        It "Throws an error when an empty or null vpgName is specified" {
            { Checkpoint-ZertoVpg -vpgName "" -checkpointName "MyCheckPoint" } | Should -Throw
            { Checkpoint-ZertoVpg -vpgName $null -checkpointName "MyCheckPoint" } | Should -Throw
        }

        It "Does not support 'SupportsShouldProcess'" {
            Get-Command $script:function | Should -Not -HaveParameter WhatIf
            Get-Command $script:function | Should -Not -HaveParameter Confirm
            $script:ScriptBlock | Should -not -match 'SupportsShouldProcess'
            $script:ScriptBlock | Should -not -match '\$PSCmdlet\.ShouldProcess\(.+\)'
        }
    }

    Context "$($script:function)::Function Unit Tests" {

        It "should return a not null or empty string" {
            $results = Checkpoint-ZertoVpg -vpgName "MyVpg" -checkpointName "My Checkpoint Name"
            $results | Should -not -BeNullOrEmpty
            $results | Should -BeOfType "String"
            $results | Should -BeExactly "7e79035e-fb8c-47fe-815c-12ddd41708e6.3e4cdd0d-1064-4022-921f-6265ad6d335a"
        }
        It "does not return anything when a invalid VPG is defined" {
            $results = Checkpoint-ZertoVpg -vpgName "DoesNotExist" -checkpointName "My Checkpoint Name"
            $results | Should -Be "Cannot find VPG named DoesNotExist. Please check the name and try again."
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -Exactly 2
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoVpg -Exactly 1
    }
}
