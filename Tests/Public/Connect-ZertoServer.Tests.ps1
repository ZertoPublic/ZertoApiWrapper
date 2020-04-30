#Requires -Modules Pester
$global:here = (Split-Path -Parent $PSCommandPath)
$global:function = ((Split-Path -leaf $PSCommandPath).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {
    BeforeAll {
        $script:ScriptBlock = (Get-Command $global:function).ScriptBlock
    }

    Context "$($global:function)::Parameter Unit Tests" {

        It "server vairable has a mandatory String parameter" {
            Get-Command $global:function | Should -HaveParameter zertoserver -Mandatory -Type String
        }

        It "server variable does not accecpt an empty or null input" {
            { Connect-ZertoServer -zertoServer $null -credential $credential } | Should -Throw
            { Connect-ZertoServer -zertoServer "" -credential $credential } | Should -Throw
        }

        It "port variable has a non-mandatory String parameter" {
            Get-Command $global:function | Should -HaveParameter zertoPort -Not -Mandatory
            Get-Command $global:function | Should -HaveParameter zertoPort -Type String
            Get-Command $global:function | Should -HaveParameter zertoPort -DefaultValue "9669"
        }

        It "port variable does not accecpt an empty or null input" {
            { Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort "" -credential $credential } | Should -Throw
            { Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort $null -credential $credential } | Should -Throw
        }

        It "port variable should fall between 1024 and 65535" {
            { Connect-ZertoServer -zertoServer $Server -zertoPort 1023 -credential $credential } | Should -Throw
            { Connect-ZertoServer -zertoServer $Server -zertoPort 65536 -credential $credential } | Should -Throw
            { Connect-ZertoServer -zertoServer $Server -zertoPort 0 -credential $credential } | Should -Throw
            { Connect-ZertoServer -zertoServer $Server -zertoPort -1 -credential $credential } | Should -Throw
        }

        It "has a mandatory PSCredential parameter for the credential vairable" {
            Get-Command $global:function | Should -HaveParameter credential -Mandatory -Type PSCredential
        }

        It "should require a PSCredentialObject for the credentials" {
            { Connect-ZertoServer -zertoServer -credential "MyUsername" } | Should -Throw
            { Connect-ZertoServer -zertoServer -credential 1234 } | Should -Throw
            { Connect-ZertoServer -zertoServer -credential $(@{Username = "zerto\build"; Password = 'SecureString' }) } | Should -Throw
        }
    }

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

        Context "$($global:function)::InModuleScope Function Unit Tests" {

            BeforeAll {
                $server = '192.168.1.100'
                $password = ConvertTo-SecureString -String "NotARealPassword" -AsPlainText -Force
                $credential = New-Object pscredential('NotARealUser', $password)
                $now = $(Get-Date).ticks
                Connect-ZertoServer -zertoServer $server -credential $credential
            }

            It "Module Scope zvmServer variable tests" {
                $script:zvmServer | Should -Not -BeNullOrEmpty
                $script:zvmServer | Should -Be $server
            }

            It "Module Scope zvmPort variable tests" {
                $script:zvmPort | Should -Not -BeNullOrEmpty
                $script:zvmPort | Should -Be '9669'
            }

            It "Module Scope zvmLastAction variable tests" {
                $script:zvmLastAction | Should -Not -BeNullOrEmpty
                $script:zvmLastAction | Should -BeGreaterOrEqual $now
            }

            It "Module Scope zvmHeaders variable tests" {
                $script:zvmHeaders | Should -Not -BeNullOrEmpty
                $script:zvmHeaders | Should -BeOfType PSCustomObject
                $script:zvmHeaders.keys.count | Should -BeExactly 3
                $script:zvmHeaders.ContainsKey('x-zerto-session') | Should -BeTrue
                $script:zvmHeaders.ContainsKey('Accept') | Should -BeTrue
                $script:zvmHeaders['x-zerto-session'] | Should -BeOfType String
                $script:zvmHeaders['Accept'] | Should -BeOfType String
            }

            It "Module Scope zvmLocalInfo variable tests" {
                $script:zvmLocalInfo | Should -Not -BeNullOrEmpty
                $script:zvmLocalInfo | Should -BeOfType PSCustomObject
                $script:zvmLocalInfo.SiteIdentifier | Should -BeOfType String
            }

            $headers = Connect-ZertoServer -zertoServer $Server -credential $credential -returnHeaders
            It "returns a Hashtable with 2 keys" {
                $headers | Should -BeOfType Hashtable
                $headers.keys.count | Should -Be 3
            }

            It "return value has a key called 'x-zerto-session'" {
                $headers.ContainsKey('x-zerto-session') | Should -Be $true
            }

            It "return key 'x-zerto-session' value should be a string" {
                $headers['x-zerto-session'] | Should -BeOfType "String"
                $headers['x-zerto-session'] | Should -BeExactly "e34da0b0-4bc2-4cda-b316-0384e35bdca5"
            }

            It "return value has a key called 'accept'" {
                $headers.ContainsKey('accept') | Should -Be $true
            }

            It "return key 'accept' value should be 'application/json'" {
                $headers['accept'] | Should -Be 'application/json'
            }

            It "should not require a port to be specified" {
                Connect-ZertoServer -zertoServer $Server -credential $credential
            }

            It "returns null when -ReturnHeaders is not used" {
                Connect-ZertoServer -zertoServer $Server -credential $credential | Should -BeNullOrEmpty
            }

            Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest -Exactly 4
            Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoLocalSite -Exactly 4
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
