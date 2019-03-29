$moduleName = "ZertoApiWrapper"
$moduleFileName = "ZertoApiWrapper.psm1"
$filePath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests', 'ZertoApiWrapper'
$docsPath = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'Tests[\\\/]Public', 'docs'
$modulePath = $filePath -replace "Public", ""

Import-Module $modulePath\$moduleFileName

Import-Module $modulePath\$moduleFileName

Describe "File Tests" {
    Remove-Module $moduleName -Force
    Import-Module $modulePath\$moduleFileName
    $commands = Get-Command -Module $moduleName | Select-Object -ExpandProperty Name
    foreach ($command in $commands) {
        $externalHelpFile = "{0}/{1}.md" -f $docsPath, $command
        $path = "{0}/{1}.ps1" -f $filePath, $command
        context "$command File Tests" {
            it "$command is backed by a file with the same name" {
                $path | should exist
            }
            it "$command file has openbraces on the same line as the statement" {
                $content = Get-Content -Path $path
                $openingBracesExist = $content | Where-Object {$_.Trim() -eq '{'}
                if ($openingBracesExist) {
                    Write-Warning "Found the following opening brances on their own line:"
                    foreach ($openingBrace in $openingBracesExist) {
                        Write-Warning "Opening Brace on it's own line - $openingBrace"
                    }
                }
                $openingBracesExist | should benullorempty
            }
            it "$command has an external help file" {
                $externalHelpFile | should exist
            }
            it "$command has the External Help File Defined" {
                Get-Content -Path $path -First 1 | should be "<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>"
            }
            it "$command external Help file is filled out" {
                $stubExist = Get-Content -Path $externalHelpFile | Where-Object {$_.Trim() -like '*{{*}}*'}
                if ($stubExist) {
                    Write-Warning "Found a stub in the Markdown File $externalHelpFile"
                    Write-Warning "$stubExist"
                }
                $stubExist | should benullorempty
            }
        }
    }
}
