

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

###  Zerto Analytics

* Added several functions for the newly added [Zerto Analytics](https://analytics.zerto.com) Planner.
  * `Get-ZAPlannerSite` Help can be found here: [Get-ZAPlannerSite](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerSite.md)
  * `Get-ZAPlannerStatsReport` Help can be found here: [Get-ZAPlannerStatsReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerStatsReport.md)
  * `Get-ZAPlannerJournalSizeReport` Help can be found here: [Get-ZAPlannerJournalSizeReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerJournalSizeReport.md)
  * `Get-ZAPlannerNetworkPerformanceReport` Help can be found here: [Get-ZAPlannerNetworkPerformanceReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerNetworkPerformanceReport.md)
  * `Get-ZAPlannerWanReport` Help can be found here: [Get-ZAPlannerWanReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerWanReport.md)
  * `Get-ZAPlannerZcasReport` Help can be found here: [Get-ZAPlannerZcasReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerZcasReport.md)
* Created `Get-ZAProtectedVm` and `Get-ZAProtectedVmReport` functions to leverage the newly released Zerto Analytics APIs for this data. Help files can be found here: [Get-ZAProtectedVm](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAProtectedVm.md) and [Get-ZAProtectedVmReport](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAProtectedVmReport.md)
