#Requires -Modules Pester
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace("Tests", "ZertoApiWrapper")
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force
$userName = "zerto\build"
$password = ConvertTo-SecureString -String "ZertoBuild" -AsPlainText -Force
$credential = New-Object -TypeName System.Management.Automation.PSCredential($userName, $password)
$Server = "192.168.1.100"
$zertoPort = "7669"

Describe $file.BaseName -Tag Unit {
    Context "Basic Features" {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
            $xZertoSession = @("7ecf544d-e7ed-4108-86f3-fb355c51cdfa")
            $Headers = @{'x-zerto-session' = $xZertoSession}
            $results = @{'Headers' = $Headers}
            return $results
        }

        Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoLocalSite {
            $results = @{
                BandwidthThrottlingInMBs   = -1
                ContactEmail               = "vSphere-Site01@zerto.com"
                ContactName                = "vSphere-Site01@zerto.com"
                ContactPhone               = "066-6666666"
                IpAddress                  = "192.168.200.1"
                IsReplicationToSelfEnabled = $True
                Link                       = @{
                    href       = "https://192.168.24.1:7669/v1/localsite"
                    identifier = "928a122b-1763-4664-ad37-cc00bb883f2f"
                    rel        = $null
                    type       = "LocalSiteApi"
                }
                Location                   = "vSphere-Site01"
                SiteName                   = "vSphere-Site01 at Zerto"
                SiteType                   = "VCenter"
                UtcOffsetInMinutes         = -240
                Version                    = "7.0.0"
                SiteIdentifier             = "928a122b-1763-4664-ad37-cc00bb883f2f"
            }
            return $results
        }

        It "is valid Powershell (Has no script errors)" {
            $contents = Get-Content -Path $file -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
            $errors | Should -HaveCount 0
        }

        it "server vairable has a mandatory String parameter" {
            Get-Command $file.BaseName | Should -HaveParameter zertoserver -Mandatory -Type String
        }

        it "server variable does not accecpt an empty or null input" {
            {Connect-ZertoServer -zertoServer $null -credential $credential} | Should -Throw
            {Connect-ZertoServer -zertoServer "" -credential $credential} | Should -Throw
        }

        it "port variable has a non-mandatory String parameter" {
            Get-Command $file.BaseName | Should -HaveParameter zertoPort -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter zertoPort -Type String
            Get-Command $file.BaseName | Should -HaveParameter zertoPort -DefaultValue "9669"
        }

        it "port variable does not accecpt an empty or null input" {
            {Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort "" -credential $credential} | Should -Throw
            {Connect-ZertoServer -zertoServer "192.168.1.100" -zertoPort $null -credential $credential} | Should -Throw
        }

        it "port variable should fall between 1024 and 65535" {
            {Connect-ZertoServer -zertoServer $Server -zertoPort 1023 -credential $credential} | Should -Throw
            {Connect-ZertoServer -zertoServer $Server -zertoPort 65536 -credential $credential} | Should -Throw
        }

        it "has a mandatory PSCredential parameter for the credential vairable" {
            Get-Command $file.BaseName | Should -HaveParameter credential -Mandatory -Type PSCredential
        }

        it "returns null when -ReturnHeaders is not used" {
            Connect-ZertoServer -zertoServer $Server -zertoPort $zertoPort -credential $credential | Should -BeNullOrEmpty
        }

        $headers = Connect-ZertoServer -zertoServer $Server -zertoPort $zertoPort -credential $credential -returnHeaders
        it "returns a Hashtable with 2 keys" {
            $headers | Should -BeOfType Hashtable
            $headers.keys.count | should be 2
        }

        it "return value has a key called 'x-zerto-session'" {
            $headers.ContainsKey('x-zerto-session') | should be $true
        }

        it "return key 'x-zerto-session' value should be a string" {
            $headers['x-zerto-session'] | should -BeOfType "String"
            $headers['x-zerto-session'] | Should -BeExactly "7ecf544d-e7ed-4108-86f3-fb355c51cdfa"
        }

        it "return value has a key called 'accept'" {
            $headers.ContainsKey('accept') | should be $true
        }

        it "return key 'accept' value should be 'application/json'" {
            $headers['accept'] | should be 'application/json'
        }

        it "should not require a port to be specified" {
            Connect-ZertoServer -zertoServer $Server -credential $credential
        }

        it "should require a PSCredentialObject for the credentials" {
            {Connect-ZertoServer -zertoServer -credential "MyUsername"} | Should -Throw
            {Connect-ZertoServer -zertoServer -credential 1234} | Should -Throw
            {Connect-ZertoServer -zertoServer -credential $(@{Username = "zerto\build"; Password = 'SecureString'})} | Should -Throw
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest
        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoLocalSite
    }

    InModuleScope ZertoApiWrapper {
        Context "InModuleScope Tests" {

            $userName = "zerto\build"
            $password = ConvertTo-SecureString -String "ZertoBuild" -AsPlainText -Force
            $credential = New-Object -TypeName System.Management.Automation.PSCredential($userName, $password)


            Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
                $xZertoSession = @("7ecf544d-e7ed-4108-86f3-fb355c51cdfa")
                $Headers = @{'x-zerto-session' = $xZertoSession}
                $results = @{'Headers' = $Headers}
                return $results
            }

            Mock -ModuleName ZertoApiWrapper -CommandName Get-ZertoLocalSite {
                $results = @{
                    BandwidthThrottlingInMBs   = -1
                    ContactEmail               = "vSphere-Site01@zerto.com"
                    ContactName                = "vSphere-Site01@zerto.com"
                    ContactPhone               = "066-6666666"
                    IpAddress                  = "192.168.200.1"
                    IsReplicationToSelfEnabled = $True
                    Link                       = @{
                        href       = "https://192.168.24.1:7669/v1/localsite"
                        identifier = "928a122b-1763-4664-ad37-cc00bb883f2f"
                        rel        = $null
                        type       = "LocalSiteApi"
                    }
                    Location                   = "vSphere-Site01"
                    SiteName                   = "vSphere-Site01 at Zerto"
                    SiteType                   = "VCenter"
                    UtcOffsetInMinutes         = -240
                    Version                    = "7.0.0"
                    SiteIdentifier             = "928a122b-1763-4664-ad37-cc00bb883f2f"
                }
                return $results
            }

            $now = $(Get-Date).ticks
            Connect-ZertoServer -zertoServer '192.168.1.100' -credential $credential

            it "Module Scope zvmServer variable tests" {
                $script:zvmServer | Should -Not -BeNullOrEmpty
                $script:zvmServer | Should -Be '192.168.1.100'
            }

            it "Module Scope zvmPort variable tests" {
                $script:zvmPort | Should -Not -BeNullOrEmpty
                $script:zvmPort | Should -Be '9669'
            }

            it "Module Scope zvmLastAction variable tests" {
                $script:zvmLastAction | Should -Not -BeNullOrEmpty
                $script:zvmLastAction | Should -BeGreaterOrEqual $now
            }

            it "Module Scope zvmHeaders variable tests" {
                $script:zvmHeaders | Should -Not -BeNullOrEmpty
                $script:zvmHeaders | Should -BeOfType Hashtable
                $script:zvmHeaders.keys.count | Should -BeExactly 2
                $script:zvmHeaders.ContainsKey('x-zerto-session') | Should -BeTrue
                $script:zvmHeaders.ContainsKey('Accept') | Should -BeTrue
                $script:zvmHeaders['x-zerto-session'] | Should -BeOfType String
                $script:zvmHeaders['Accept'] | Should -BeOfType String
            }

            it "Module Scope zvmLocalInfo variable tests" {
                $script:zvmLocalInfo | Should -Not -BeNullOrEmpty
                $script:zvmLocalInfo | Should -BeOfType Hashtable
                $script:zvmLocalInfo['SiteIdentifier'] | Should -BeOfType String
                $script:zvmLocalInfo.ContainsKey('SiteIdentifier') | Should -BeTrue
                $script:zvmLocalInfo['SiteIdentifier'] | Should -BeOfType String
            }

            Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest
            Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoLocalSite
        }
    }
}
<#
Describe "Connect-ZertoServer" -Tag Integration {
    it "file should exist" {
        "$filePath\$fileName" | should exist
    }
    it "has a function called Connect-ZertoServer" {
        get-command Connect-ZertoServer | should be $true
    }
    $headers = Connect-ZertoServer -zertoServer $Server -zertoPort $zertoPort -credential $credential -returnHeaders
    it "returns a Hashtable with 2 keys" {
        $headers.keys.count | should be 2
    }
    it "return value has a key called 'x-zerto-session'" {
        $headers.ContainsKey('x-zerto-session') | should be $true
    }
    it "return key 'x-zerto-session' value should be a string" {
        $headers['x-zerto-session'].gettype().name | should be "String"
    }
    it "return value has a key called 'accept'" {
        $headers.ContainsKey('accept') | should be $true
    }
    it "return key 'accept' value should be 'application/json'" {
        $headers['accept'] | should be 'application/json'
    }
    Disconnect-ZertoServer
}
 #>
