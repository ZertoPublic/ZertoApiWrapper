$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$publicFiles = Get-ChildItem "$filePath" -File

describe "External Help Present" {
    foreach ($file in $publicFiles) {
        it "External Help File Defined" {
            Get-Content -Path $file.fullName -First 1 | should be "<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>"
        }
    }
}
