#Requires -Modules Pester
$moduleFileName = "ZertoApiWrapper.psd1"
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path).Replace("Tests", "ZertoApiWrapper")
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
$file = Get-ChildItem "$here\$sut"
$modulePath = $here -replace "Public", ""
$moduleFile = Get-ChildItem "$modulePath\$moduleFileName"
Get-Module -Name ZertoApiWrapper | Remove-Module -Force
Import-Module $moduleFile -Force

Describe $file.BaseName -Tag 'Unit' {

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    Context "$($file.BaseName)::Parameter Unit Tests" {

        It "Has a mandatory string host name parameter" {
            Get-Command $file.BaseName | Should -HaveParameter hostName
            Get-Command $file.BaseName | Should -HaveParameter hostName -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter hostName -Type String
        }

        It "Will not accecpt a Null or Empty string for the host name" {
            {Install-ZertoVra -hostName $null -datastoreName "DS01" -networkName "MyNetwork" -Dhcp } | Should -Throw "The argument is null or empty"
            {Install-ZertoVra -hostName "" -datastoreName "DS01" -networkName "MyNetwork" -Dhcp } | Should -Throw "The argument is null or empty"
        }

        It "Has a mandatory string datastore parameter" {
            Get-Command $file.BaseName | Should -HaveParameter datastoreName
            Get-Command $file.BaseName | Should -HaveParameter datastoreName -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter datastoreName -Type String
        }

        It "Will not accecpt a Null or Empty string for the datastore" {
            {Install-ZertoVra -hostName "MyfirstHost" -datastoreName $null -networkName "MyNetwork" -Dhcp } | Should -Throw "The argument is null or empty"
            {Install-ZertoVra -hostName "MyfirstHost" -datastoreName "" -networkName "MyNetwork" -Dhcp } | Should -Throw "The argument is null or empty"
        }

        It "Has a mandatory string network parameter" {
            Get-Command $file.BaseName | Should -HaveParameter networkName
            Get-Command $file.BaseName | Should -HaveParameter networkName -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter networkName -Type String
        }

        It "Will not accecpt a Null or Empty string for the datastore" {
            {Install-ZertoVra -hostName "MyfirstHost" -datastoreName "DS01" -networkName $null -Dhcp } | Should -Throw "The argument is null or empty"
            {Install-ZertoVra -hostName "MyfirstHost" -datastoreName "DS01" -networkName "" -Dhcp } | Should -Throw "The argument is null or empty"
        }

        it "Has a switch parameter for setting DHCP" {
            Get-Command $file.BaseName | Should -HaveParameter Dhcp
            Get-Command $file.BaseName | Should -HaveParameter Dhcp -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter Dhcp -Type 'Switch'

        }

        it "Has a mandatory string parameter for the static IP address" {
            Get-Command $file.BaseName | Should -HaveParameter vraIpAddress
            Get-Command $file.BaseName | Should -HaveParameter vraIpAddress -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter vraIpAddress -Type String
        }

        it "Has a mandatory string parameter for the subnet mask" {
            Get-Command $file.BaseName | Should -HaveParameter subnetMask
            Get-Command $file.BaseName | Should -HaveParameter subnetMask -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter subnetMask -Type String
        }

        it "Has a mandatory string parameter for the default gateway" {
            Get-Command $file.BaseName | Should -HaveParameter defaultGateway
            Get-Command $file.BaseName | Should -HaveParameter defaultGateway -Mandatory
            Get-Command $file.BaseName | Should -HaveParameter defaultGateway -Type String
        }

        $cases = `
        @{invalidIpAddress = "192.168.1.256"}, `
        @{invalidIpAddress = "192.168.1"}, `
        @{invalidIpAddress = "String"}, `
        @{invalidIpAddress = 192.168.1.246}, `
        @{invalidIpAddress = 32}, `
        @{invalidIpAddress = ""}, `
        @{invalidIpAddress = $null}
        It "IpAddress field require valid IP addresses as a String: <invalidIpAddress>" -TestCases $cases {
            param ( $invalidIpAddress )
            {Install-ZertoVra -hostName "MyFirstHost" -datastoreName "DS01" -networkName "MyNetwork" -vraIpAddress $invalidIpAddress -subnetMask "255.255.255.0" -defaultGateway "192.168.1.254"} | Should -Throw
        }

        It "Default Gateway field require valid IP addresses as a String: <invalidIpAddress>" -TestCases $cases {
            param ( $invalidIpAddress )
            {Install-ZertoVra -hostName "MyFirstHost" -datastoreName "DS01" -networkName "MyNetwork" -vraIpAddress '192.168.1.100' -subnetMask "255.255.255.0" -defaultGateway $invalidIpAddress} | Should -Throw
        }

        It "Subnet Mask field require valid IP addresses as a String: <invalidIpAddress>" -TestCases $cases {
            param ( $invalidIpAddress )
            {Install-ZertoVra -hostName "MyFirstHost" -datastoreName "DS01" -networkName "MyNetwork" -vraIpAddress '192.168.1.100' -subnetMask $invalidIpAddress -defaultGateway "192.168.1.254"} | Should -Throw
        }

    }

    Context "$($file.BaseName)::Function Unit Tests" {

    }
}
