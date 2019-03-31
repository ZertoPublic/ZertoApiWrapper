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
$zertoServer = "192.168.1.100"
$zertoPort = "7669"

Describe $file.BaseName -Tag Unit {
    Context "Basic Features" {
        Mock -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest {
            $xZertoSession = @("7ecf544d-e7ed-4108-86f3-fb355c51cdfa")
            $Headers = @{'x-zerto-session' = $xZertoSession}
            $results = @{'Headers' = $Headers}
            return $results
        }

        It "is valid Powershell (Has no script errors)" {
            $contents = Get-Content -Path $file -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
            $errors | Should -HaveCount 0
        }

        it "has a mandatory String parameter for the server vairable" {
            Get-Command $file.BaseName | Should -HaveParameter zertoserver -Mandatory -Type String
        }

        it "has a non-mandatory String parameter for the port variable" {
            Get-Command $file.BaseName | Should -HaveParameter zertoPort -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter zertoPort -Type String
        }

        it "has a mandatory PSCredential parameter for the credential vairable" {
            Get-Command $file.BaseName | Should -HaveParameter credential -Mandatory -Type PSCredential
        }

        it "returns null when -ReturnHeaders is not used" {
            Connect-ZertoServer -zertoServer $zertoServer -zertoPort $zertoPort -credential $credential | Should -BeNullOrEmpty
        }

        $headers = Connect-ZertoServer -zertoServer $zertoServer -zertoPort $zertoPort -credential $credential -returnHeaders
        it "returns a Hashtable with 2 keys" {
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
            Connect-ZertoServer -zertoServer $zertoServer -credential $credential
        }

        it "should require a PSCredentialObject for the credentials" {
            {Connect-ZertoServer -zertoServer -credential "MyUsername"} | Should -Throw
            {Connect-ZertoServer -zertoServer -credential 1234} | Should -Throw
            {Connect-ZertoServer -zertoServer -credential $(@{Username = "zerto\build"; Password = 'SecureString'})} | Should -Throw
        }

        Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest
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
    $headers = Connect-ZertoServer -zertoServer $zertoServer -zertoPort $zertoPort -credential $credential -returnHeaders
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