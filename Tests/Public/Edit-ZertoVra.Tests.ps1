#Requires -Modules Pester
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -Replace "Tests", "ZertoApiWrapper"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force

Describe $file.BaseName -Tag 'Unit' {

    Mock -ModuleName ZertoApiWrapper Invoke-ZertoRestRequest {
        return "8dcfdc8e-e5d2-4ba4-9885-f9eb57d92b14.928a122b-1763-4664-ad37-cc00bb883f2f"
    }

    Mock -ModuleName ZertoApiWrapper Get-ZertoVra {
        $vraInformation = @{
            DatastoreClusterIdentifier = $null
            DatastoreClusterName       = $null
            DatastoreIdentifier        = "840f99fb-4689-2f8b-ea10-2a47a5bb00cc.Prod_Datastore"
            DatastoreName              = "Prod_Datastore"
            HostIdentifier             = "840f99fb-4689-2f8b-ea10-2a47a5bb00cc.znest82esxus-1"
            HostVersion                = 6.5
            IpAddress                  = 192.168.1.100
            Link                       = @{
                href       = "https://192.168.1.200:7669/v1/vras/2609816293328110468"
                identifier = "269816293328110468"
                rel        = $null
                type       = "VraApi"
            }
            MemoryInGB                 = 3
            NetworkIdentifier          = "840f99fb-4689-2f8b-ea10-2a47a5bb00cc.network-1"
            NetworkName                = "Test Network"
            Progress                   = 0
            ProtectedCounters          = @{
                Vms     = 0
                Volumes = 0
                Vpgs    = 0
            }
            RecoveryCounters           = @{
                Vms     = 0
                Volumes = 0
                Vpgs    = 0
            }
            SelfProtectedVpgs          = 0
            Status                     = 0
            VraAlerts                  = @{
                VraAlertStatus = 0
            }
            VraGroup                   = "default_group"
            VraIdentifier              = 269816293328110468
            VraIdentifierStr           = "269816293328110468"
            VraName                    = "VRA-znest82esxus-1"
            VraNetworkDataApi          = @{
                DefaultGateway            = "192.168.1.1"
                SubnetMask                = "255.255.255.0"
                VraIpAddress              = "192.168.1.100"
                VraIpConfigurationTypeApi = "Dhcp"
            }
            VraVersion                 = 7.0
        }
        return $vraInformation
    }

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    Context "$($File.BaseName)::Parameter Tests" {

        It "has a mandatory String variable for the vraIdentifier" {
            Get-Command $file.BaseName | Should -HaveParameter vraIdentifier -Mandatory -Type String
            {Edit-ZertoVra}
        }

        It "has a non-mandatory String variable for the Bandwidth Group" {
            Get-Command $file.BaseName | Should -HaveParameter groupName -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter groupName -Type String
        }

        it "has a non-mandatory String variable for the staticIp Address" {
            Get-Command $file.BaseName | Should -HaveParameter vraIpAddress -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter vraIpAddress -Type String
        }

        it "has a non-mandatory String variable for the default gateway" {
            Get-Command $file.BaseName | Should -HaveParameter defaultGateway -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter defaultGateway -Type String
        }

        it "has a non-mandatory String variable for the subnetmask" {
            Get-Command $file.BaseName | Should -HaveParameter subnetMask -Not -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter subnetMask -Type String
        }

        it "supports WhatIf" {
            Get-Command $file.BaseName | Should -HaveParameter WhatIf -Not -Mandatory
        }

        $cases = `
        @{vraIpAddress = "192.168.1.256"}, `
        @{vraIpAddress = "192.168.1"}, `
        @{vraIpAddress = "String"}, `
        @{vraIpAddress = 192.168.1}, `
        @{vraIpAddress = 192.168.1.246}, `
        @{vraIpAddress = 32}, `
        @{vraIpAddress = ""}
        It "IpAddress field require valid IP addresses as a String" -TestCases $cases {
            param ( $vraIpAddress )
            {Edit-ZertoVra -vraIdentifier "MyVraIdentifier" -vraIpaddress $vraIpAddress} | Should -Throw
        }

        $cases = `
        @{subnetMask = "192.168.1.256"}, `
        @{subnetMask = "192.168.1"}, `
        @{subnetMask = "String"}, `
        @{subnetMask = 192.168.1}, `
        @{subnetMask = 192.168.1.246}, `
        @{subnetMask = 32}, `
        @{subnetMask = ""}
        It "subnetMask field require valid IP addresses as a String" -TestCases $cases {
            param ( $vraIpAddress )
            {Edit-ZertoVra -vraIdentifier "MyVraIdentifier" -subnetMask $subnetMask} | Should -Throw
        }

        $cases = `
        @{defaultGateway = "192.168.1.256"}, `
        @{defaultGateway = "192.168.1"}, `
        @{defaultGateway = "String"}, `
        @{defaultGateway = 192.168.1}, `
        @{defaultGateway = 192.168.1.246}, `
        @{defaultGateway = 32}, `
        @{defaultGateway = ""}
        It "defaultGateway field require valid IP addresses as a String" -TestCases $cases {
            param ( $vraIpAddress )
            {Edit-ZertoVra -vraIdentifier "MyVraIdentifier" -defaultGateway $defaultGateway} | Should -Throw
        }

        $cases = `
        @{vraIdentifier = ""; paramName = "vraIdentifier"; paramValue = ""}, `
        @{vraIdentifier = "MyVraIdentifier"; paramName = "groupName"; paramValue = ""}, `
        @{vraIdentifier = "MyVraIdentifier"; paramName = "vraIpAddress"; paramValue = ""}, `
        @{vraIdentifier = "MyVraIdentifier"; paramName = "subnetMask"; paramValue = ""}, `
        @{vraIdentifier = "MyVraIdentifier"; paramName = "defaultGateway"; paramValue = ""}

        It "<paramName> does not take empty strings" -TestCases $cases {
            param($vraIdentifier, $paramValue, $paramName )
            if ([String]::IsNullOrEmpty($vraIdentifier)) {
                {Edit-ZertoVra -vraIdentifier $vraIdentifier} | Should -Throw
            } else {
                {Edit-ZertoVra -vraIdentifier $vraIdentifier -$paramName $paramValue} | should -Throw
            }
        }
    }

    Context "$($File.BaseName)::Function Tests" {

        It "Returns a string" {
            $results = Edit-ZertoVra -vraIdentifier "MyVraIdentifier" -groupName "MyGroup"
            $results | should not benullorempty
            $results | should -BeOfType "String"
            $results | Should -BeExactly "8dcfdc8e-e5d2-4ba4-9885-f9eb57d92b14.928a122b-1763-4664-ad37-cc00bb883f2f"
        }

        it "Supports 'SupportsShouldProcess'" {
            Get-Command $file.BaseName | Should -HaveParameter WhatIf
            Get-Command $file.BaseName | Should -HaveParameter Confirm
            $file | Should -FileContentMatch 'SupportsShouldProcess'
            $file | Should -FileContentMatch '\$PSCmdlet\.ShouldProcess\(.+\)'
        }

    }
    Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Invoke-ZertoRestRequest
    Assert-MockCalled -ModuleName ZertoApiWrapper -CommandName Get-ZertoVra
}