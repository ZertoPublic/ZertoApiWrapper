# ZertoApiWrapper

PowerShell wrapper for Zerto Virtual Manager API

## Current Build Status

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/0e31e5cdad534271ac688a82cc3ca17d)](https://app.codacy.com/app/wcarroll/ZertoApiWrapper?utm_source=github.com&utm_medium=referral&utm_content=wcarroll/ZertoApiWrapper&utm_campaign=Badge_Grade_Settings)
[![Build Status](https://dev.azure.com/ZertoPublic/ZertoApiWrapper/_apis/build/status/ZertoPublic.ZertoApiWrapper?branchName=master)](https://dev.azure.com/ZertoPublic/ZertoApiWrapper/_build/latest?definitionId=1&branchName=master)

## Legal Disclaimer

This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.

## Disclaimer

This code is still under development! Please use carefully and if you encounter any issues or have an idea, please submit an [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues). Along the same lines, should you be proficient in PowerShell, please feel free to submit any [Pull Requests](https://github.com/ZertoPublic/ZertoApiWrapper/pulls) with enhancements and bug fixes.

## Installing the Module

This module can be installed directly from the [PowerShell Gallery](https://www.powershellgallery.com/packages/ZertoApiWrapper) with the following command.
```
PS> Install-Module -name ZertoApiWrapper
```

## Getting Started

* [Getting Started with Zerto Virtual Manager and the ZertoApiWrapper](https://github.com/ZertoPublic/ZertoApiWrapper/wiki/Getting-Stated-with-Zerto-Virtual-Manager)
* [Getting Started with Zerto Analytics and the ZertoApiWrapper](https://github.com/ZertoPublic/ZertoApiWrapper/wiki/Getting-Started-with-Zerto-Analytics)

## Recent Updates

* June 16th, 2019: Added functionality for Zerto Analytics.
* May 31st, 2019: Implement logic to allow use of this module in both Windows PowerShell 5.1 and PowerShell Core.
* March 15th, 2019: Implement Export and Import Functionality. Please See [Export-ZertoVpg Help](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Export-ZertoVpg.md) and [Import-ZertoVpg Help](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Import-ZertoVpg.md) for assistance. No current pre-seed support.
* March 11th, 2019: Create basic VPG completed. Please see [New-ZertoVpg Help](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/New-ZertoVpg.md)

## TODO

* Complete Help Markdown Files
* JFLR Functionality
* Create VPG (Per-VM modification and Backup Settings)
* Edit VPG
* Delete Zerto License
* Flesh out Pester Tests
* Complete Automated Build Process
