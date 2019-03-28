# Bootstrap the environment
$null = Get-PackageProvider -Name NuGet -ForceBootstrap

if (-not (Get-Module -Name PSDepend -ListAvailable)) {
    Install-Module -Name PSDepend -Scope CurrentUser -Force -Confirm:$false
}

Import-Module -Name PSDepend
Invoke-PSDepend `
    -Path $PSScriptRoot `
    -Force `
    -Import `
    -Install `
    -Tags 'Bootstrap'

Invoke-Build .
