#Requires -Modules Pester
$testPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$docsPath = $testPath -replace 'Tests', 'docs'
$modulePath = $testPath -replace 'Tests', 'ZertoApiWrapper'
$module = Split-Path -Leaf $modulePath

Describe "Module: $module" -Tags 'Unit' {

    Context "Module Configuration" {

        It "Has a root module file ($module.psm1)" {
            "$modulePath\$module.psm1" | should -Exist
        }

        It "Is valid Powershell (Has no script errors)" {
            $contents = Get-Content -Path "$modulePath\$module.psm1" -ErrorAction SilentlyContinue
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
            $errors | Should -HaveCount 0
        }

        It "Has a manifest file ($module.psd1)" {

            "$modulePath\$module.psd1" | Should -Exist
        }

        It "Contains a root module path in the manifest (RootModule = '.\$module.psm1')" {

            "$modulePath\$module.psd1" | Should -Exist
            "$modulePath\$module.psd1" | Should -FileContentMatch "\.\\$module.psm1"
        }

        It "Has a public functions folder" {

            "$modulePath\Public" | Should -Exist
        }

        It "Has functions in the public functions folder" {

            "$modulePath\Public\*.ps1" | Should -Exist
        }

        It "Has a private functions folder" {

            "$modulePath\Private" | Should -Exist
        }

        It "Has functions in the private functions folder" {

            "$modulePath\Private\*.ps1" | Should -Exist
        }
    }

    $Functions = Get-ChildItem $modulePath -Recurse -Include '*.ps1' -ErrorAction SilentlyContinue

    foreach ($function in $functions) {
        $contents = Get-Content -Path $function.FullName -ErrorAction Stop
        $externalHelpFile = "{0}\{1}.md" -f $docsPath, $function.BaseName
        Context "Function $module::$($Function.BaseName)" {

            It "Has a Pester Test" {
                $testFunction = ($Function.Name) -Replace '.ps1', '.Tests.ps1'
                $functionFolder = (Split-Path -leaf $(Split-Path -Parent $function.FullName))
                $testFunctionPath = "{0}\{1}\{2}" -f $testPath, $functionFolder, $testFunction
                $testFunctionPath | Should -Exist
            }

            if ( -not ($function.directoryname.contains('Private'))) {

                It "Has an external help file defined" {
                    $contents | Select-Object -First 1 | Should -Be "<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>"
                }

                It "Has an external help markdown file" {
                    $externalHelpFile | Should -Exist
                }

                it "External Help file does not contain place holder values" {
                    $stubExist = Get-Content -Path $externalHelpFile | Where-Object {$_.Trim() -like '*{{*}}*'}
                    if ($stubExist) {
                        Write-Warning "Found a stub in the Markdown File $externalHelpFile"
                        Write-Warning "$stubExist"
                    }
                    $stubExist | should benullorempty
                }
            }

            It "Is an advanced function" {
                $Function.FullName | should -FileContentMatch 'function'
                $Function.FullName | should -FileContentMatch 'cmdletbinding'
                $Function.FullName | should -FileContentMatch 'param'
            }

            It "Is valid Powershell (Has no script errors)" {
                $errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
                $errors | Should -HaveCount 0
            }

            it "Has openbraces on the same line as the statement" {
                $openingBracesExist = $contents | Where-Object {$_.Trim() -eq '{'}
                if ($openingBracesExist) {
                    Write-Warning "Found the following opening brances on their own line:"
                    foreach ($openingBrace in $openingBracesExist) {
                        Write-Warning "Opening Brace on it's own line - $openingBrace"
                    }
                }
                $openingBracesExist | should -BeNullOrEmpty
            }
        }
    }
}
