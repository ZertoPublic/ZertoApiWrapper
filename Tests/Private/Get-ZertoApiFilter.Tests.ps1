$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$fileName = (Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '.Tests.', '.'
$file = Get-ChildItem "$filePath\$fileName"

. $file.FullName
$singleBoolItemTest = @{"BoolItem" = $True}
$oneItemTest = @{"OneItem" = "Test"}
$twoItemTest = @{"OneItem" = "Test"; "SecondItem" = "Yours"}
$boolItemTest = @{"OneItem" = "Test"; "BoolItem" = $true}

Describe $file.BaseName -Tag Unit {
    it "file should exist" {
        $file.Fullname | should exist
    }

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file.Fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }

    it "converts bool to text" {
        Get-ZertoApiFilter -filtertable $singleBoolItemTest | should -Be "?BoolItem=True"
    }
    it "one item test" {
        Get-ZertoApiFilter -filtertable $oneItemTest | should be "?OneItem=Test"
    }
    #TODO:: Figure out multi-item tests
}
