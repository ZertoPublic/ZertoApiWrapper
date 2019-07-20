#Requires -Modules Pester
$global:here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$global:function = ((Split-Path -leaf $MyInvocation.MyCommand.Path).Split('.'))[0]

Describe $global:function -Tag 'Unit', 'Source', 'Built' {

    InModuleScope -ModuleName ZertoApiWrapper {
        Context "$global:function::Parameter Unit Tests" {
            it "have a mandatory parameter for the Input Object" {
                Get-Command $global:function | Should -HaveParameter InputObject -Mandatory -Type PSCustomObject
            }

            it "Input Object should not accecpt a Null or Empty value" {
                $myObj = [PSCustomObject]@{ }
                { Get-Map -InputObject $myObj -Key "Key" -Value "Value" } | Should Throw
                { Get-Map -InputObject $null -Key "Key" -Value "Value" } | Should Throw
                { Get-Map -InputObject "" -Key "Key" -Value "Value" } | Should Throw
            }

            it "have a mandatory string parameter for the Map Key" {
                Get-Command $global:function | Should -HaveParameter Key -Mandatory -Type String
            }

            it "The Map variable should not accecpt a Null or Empty value" {
                $myObj = [PSCustomObject]@{one = 1; two = 2 }
                { Get-Map -InputObject $myObj -Key "" -Value "Value" } | Should Throw
                { Get-Map -InputObject $null -Key $null -Value "Value" } | Should Throw
                { Get-Map -InputObject $myObj -Key 1 -Value "Value" } | Should Throw
            }

            it "The Value variable should not accecpt a Null or Empty value" {
                $myObj = [PSCustomObject]@{one = 1; two = 2 }
                { Get-Map -InputObject $myObj -Key "Key" -Value "" } | Should Throw
                { Get-Map -InputObject $myObj -Key "Key" -Value $null } | Should Throw
                { Get-Map -InputObject $myObj -Key "Key" -Value 1 } | Should Throw
            }

            it "have a mandatory string parameter for the Map Value" {
                Get-Command $global:function | Should -HaveParameter Value -Mandatory -Type String
            }

            it "should have an Output type of Hashtable" {
                (Get-Command $global:function).OutputType.Name | Should -Match "Hashtable"
            }
        }

        Context "$global:function::Function Tests" {
            $myObj = Get-Content "$global:here/Mocks/ProtectedVMs.json" | ConvertFrom-Json
            BeforeEach {
                $MyMap = Get-Map -InputObject $MyObj -Key "vmIdentifier" -Value "vmName"
            }
            it "Returned object should be a hashtable" {
                $myMap | Should -BeOfType Hashtable
            }

            it "should return a hashtable with 3 entries" {
                $myMap.count | should -Be 3
            }

            it "should be properly mapped" {
                $myMap["vmid.12"] | Should -Be "ExchangeMailbox"
                $myMap["vmid.13"] | Should -Be "ExchangeApplication"
                $myMap["vmid.14"] | Should -Be "ExchangeWeb"
            }
        }
    }
}

Remove-Variable -Name function -Scope Global
Remove-Variable -Name here -Scope Global
