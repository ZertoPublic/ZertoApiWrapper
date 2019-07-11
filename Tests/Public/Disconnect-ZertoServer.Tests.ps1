#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$script:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $script:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $script:function).ScriptBlock
    }

    Context "$($script:function)::Parameter Unit Tests" {
        it "Does not take any parameters" {
            (get-command disconnect-zertoserver).parameters.count | Should -BeExactly 11
        }
    }

    Context "$($script:function)::Function Unit Tests" {
        InModuleScope -ModuleName ZertoApiWrapper {
            Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
                # Attempted to Mock this per the Mock Below and it blew up. Auth Headers Returns a Dictionary
                # and does not index the same way when imported from a JSON file. Need addtional investigation.
                $xZertoSession = @("e34da0b0-4bc2-4cda-b316-0384e35bdca5")
                $Headers = @{'x-zerto-session' = $xZertoSession }
                $results = @{'Headers' = $Headers }
                return $results
            }

            Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoLocalSite {
                return (Get-Content -Path "$global:here\Mocks\LocalSiteInfo.json" -Raw | ConvertFrom-Json)
            }

            BeforeAll {
                Connect-ZertoServer
            }

            It "Does not return anything" {
                Disconnect-ZertoServer | Should -BeNullOrEmpty
            }
        }
    }
}
