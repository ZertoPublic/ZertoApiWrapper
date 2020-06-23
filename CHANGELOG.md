# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project is transitioning to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Zerto Virtual Manager

#### Updated

* Updated `Connect-ZertoServer` with a `-AutoReconnect` switch to allow the auto reconnection of a session that has timed-out.
* Updated `New-ZertoVpg` to have a Default Parameter Set of `recoveryHostDatastore` should no parameters be passed when calling the function.
* Updated `New-ZertoVpg -recoverySite` parameter to be case-insensitive

## [1.4.2]

### Zerto Virtual Manager

#### Fixed

* Updated `Get-ZertoEvent` to translate a vpg name parameter to a vpgIdentifier per the API documentation
* Updated `Invoke-ZertoMoveCommit` to ensure that when one of the parameter switches is defined, all required parameters are sent to avoid conflicts with parameters passed with the `Invoke-ZertoMove` command.
* Updated `Start-ZertoCloneVpg` to fix an issue where an error would be thrown if an operation specified a subset of VMs to be cloned.

## [1.4.1]

### General

* Removed RELEASENOTES and converted to a CHANGELOG format.
* Updated the build process to follow Semantic Versioning.
* Updated the build process to use the latest Pester Version (4.10.1)
* Updated the build process to use the latest PS Script Analyzer Version (1.19.0)
* Updated the Tests Files to use a more modern method of grabbing the PSScriptPath

### Zerto Virtual Manager

* Refactored `Copy-ZertoVpg` functionality to leverage identifier and name maps and eliminate `where-object` searches.
* Updated `Get-ZertoEvent` parameter to fall in line with the filter parameter name in the API documentation. Moved the old parameter name to an alias to ensure that existing functionality continues to work.

## [1.4.0.20200410]

### Zerto Virtual Manager

* Addressed a reported [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/60) in the `Get-ZertoRecoveryReport` function where the `-VpgIdentifier` parameter was not working. This parameter is not accepted by the API as a valid filter and is ignored. This parameter has been removed from the function.
* Addressed a reported [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/61) where the `Export-ZertoVpgNicSetting` function would not properly execute when run against a VM with no NICs attached.
* In reviewing the `Export-ZertoVpgNicSetting`, a review of the `Import-ZertoVpgNicSetting` was completed and it was determined to update the import logic based on various test cases. Along with this, it is now possible to reset the NIC settings to the default state with the `Import-ZertoVpgNicSetting` command. Please review the [Import-ZertoVpgNicSetting help](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Import-ZertoVmNicSetting.md) to review the updated options and import logic.
* Refactored the `Checkpoint-ZertoVpg` command to allow pipeline input (ByValue and ByProperty) for the VpgName parameter.
* Corrected a parameter typo in the `Get-ZertoVpgSetting` function. The misspelt parameter was added as an alias to ensure any existing scripts using the parameter continue to function.
* Refactored the `Get-ZertoVpg` command to remove repetitive commands and variables that are no longer required.
* Moved `Invoke-ZertoRestRequest` and `Invoke-ZARestRequest` to be public functions. As there become more and more scenarios where there are not prebuilt functions to accomplish complex specialized tasks, it became apparent that these functions could be leveraged to make the experience and workflow easier.
* Updated the `Install-ZertoVra` logic to ensure that the target datastore is available on the target host. There isn't currently any method to validate the target network, but if that becomes available in a later version of the API, the function will be updated.
* Updated the `Install-ZertoVra` function to allow for installation of the VRA using the host password method. Please review the [Install-ZertoVra](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Install-ZertoVra.md) documentation for syntax and examples.
* Updated the `Edit-ZertoVra` function to allow for modification of the associated ESX host password if the need arises. Please review the [Edit-ZertoVra](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Edit-ZertoVra.md) documentation for syntax and examples.
* Added a new function, `Set-ZertoUserCredential`, to allow the updating of the username and password used to connect the Zerto Virtual Manager to the paired hypervisor. Please see the [Set-ZertoUserCredential](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Set-ZertoUserCredential.md) help for additional information.
* With the release of [Zerto 8.0](https://www.zerto.com/zerto-8-0-general-availability/) some additional API endpoints have become available.
  * Updated `Get-ZertoVirtualizationSite` to add the `-repository` parameter to enable returning information for LTR repositories.
  * Updated `Get-ZertoVpgSetting` to add the `-ltr` parameter to enable returning information for current LTR settings for the selected VPG.

### Zerto Analytics

* Added several functions for the newly added [Zerto Analytics](https://analytics.zerto.com) Planner.
  * `Get-ZAPlannerSite` Help can be found here: [Get-ZAPlannerSite](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerSite.md)
  * `Get-ZAPlannerStatsReport` Help can be found here: [Get-ZAPlannerStatsReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerStatsReport.md)
  * `Get-ZAPlannerJournalSizeReport` Help can be found here: [Get-ZAPlannerJournalSizeReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerJournalSizeReport.md)
  * `Get-ZAPlannerNetworkPerformanceReport` Help can be found here: [Get-ZAPlannerNetworkPerformanceReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerNetworkPerformanceReport.md)
  * `Get-ZAPlannerWanReport` Help can be found here: [Get-ZAPlannerWanReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerWanReport.md)
  * `Get-ZAPlannerZcasReport` Help can be found here: [Get-ZAPlannerZcasReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerZcasReport.md)
* Created `Get-ZAProtectedVm` and `Get-ZAProtectedVmReport` functions to leverage the newly released Zerto Analytics APIs for this data. Help files can be found here: [Get-ZAProtectedVm](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAProtectedVm.md) and [Get-ZAProtectedVmReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAProtectedVmReport.md)

## [1.3.0.20191201]

### Zerto Virtual Manager

* [Zerto version 7.5 has been released.](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Release%20Notes.pdf) As part of this release Zerto has added API functionality that requires the following updates.
  * A token is now required to pair two sites together. The need is discussed in [Issue 46](https://github.com/ZertoPublic/ZertoApiWrapper/issues/46). To implement this change a `-token` parameter has been added to the `Add-ZertoPeerSite` function.
  * A new function has been added; `New-ZertoPairingToken`. This function will allow users to generate a pairing authentication token from the target ZVM to be used in the pairing process. [Issue 47](https://github.com/ZertoPublic/ZertoApiWrapper/issues/47) covers additional details.
* A new function has been added; `Invoke-ZertoEvacuateVra`. This function will allow users to evacuate a target VRA by specifying a Host Name, VRA Name, or VRA Identifier. All VMs currently replicating to the specified location will be migrated to different targets. [Issue 51](https://github.com/ZertoPublic/ZertoApiWrapper/issues/51)
* A function has been added; `Copy-ZertoVpg`. This function will allow users to copy the settings of a single VPG and add new VMs to it. There is currently no customization beyond specifying the VMs to be placed in the newly created VPG. Should additional edits \ updates be required, they should be done post creation. [Issue 54](https://github.com/ZertoPublic/ZertoApiWrapper/issues/54)
* Fixed [issue 57](https://github.com/ZertoPublic/ZertoApiWrapper/issues/57) where a `Start-ZertoFailoverTest` would throw an error complaining about validating the body parameter. This has been fixed and tested against Zerto Virtual Manager 7.5 Update 1 with Windows PowerShell 5.1 and PowerShell Core 6.2.

## [1.2.0.20190801]

### Zerto Virtual Manager

* Added two functions to aid in bulk updating of NIC information for protected VMs. ([Issue 38](https://github.com/ZertoPublic/ZertoApiWrapper/issues/38))
  * [Export-ZertoVmNicSetting](https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Export-ZertoVmNicSettings.md)
  * [Import-ZertoVmNicSetting](https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Import-ZertoVmNicSettings.md)
* Fixed an [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/43) where a VPG being created with a single VM member would not be parsed by the API correctly using PowerShell 5.1

### Zerto Analytics

* Fixed an [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/36) where the Zerto Analytics Rest Request function was not checking for the token before attempting a connection.
* Fixed an [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/40) where the `Get-ZAVpg` method would return a 404 error when a `-vpgIdentifier` parameter was specified.

### General Updates

* Updated the way that tests are invoked and parsed to ensure that both source and built module files are tested. This will ensure that what is being shipped passes all tests along with testing of the source files.
* Added additional parameter validation tests to several of the functions. On-going effort to complete stand alone unit testing of each function.

## [Initial Release]

### Zerto Virtual Manager

* Updated `Invoke-ZertoRestRequest` to work in Powershell 5.1 as well as Powershell core

### Zerto Analytics

* Implemented Zerto Analytics Functionality. Please see [Getting Started with Zerto Analytics](https://github.com/ZertoPublic/ZertoApiWrapper/wiki/Getting-Started-with-Zerto-Analytics)
