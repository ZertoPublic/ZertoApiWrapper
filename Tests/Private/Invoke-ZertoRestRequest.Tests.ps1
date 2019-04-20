$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$fileName = (Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '.Tests.', '.'
$file = Get-ChildItem "$filePath\$fileName"
. $file.FullName

Describe $file.BaseName -Tag Unit {
    it "file should exist" {
        $file.FullName | should exist
    }

    It "is valid Powershell (Has no script errors)" {
        $contents = Get-Content -Path $file.FullName -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors | Should -HaveCount 0
    }
}