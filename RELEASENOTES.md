

### Zerto Virtual Manager

* Addressed a reported [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/60) in the `Get-ZertoRecoveryReport` function where the `-VpgIdentifier` parameter was not working. This parameter is not accepted by the API as a valid filter and is ignored. This parameter has been removed from the function.
* Addressed a reported [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/61) where the `Export-ZertoVpgNicSetting` function would not properly execute when run against a VM with no NICs attached.
* In reviewing the `Export-ZertoVpgNicSetting`, a review of the `Import-ZertoVpgNicSetting` was completed and it was determined to update the import logic based on various test cases. Along with this, it is now possible to reset the NIC settings to the default state with the `Import-ZertoVpgNicSetting` command. Please review the [Import-ZertoVpgNicSetting help](https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Import-ZertoVmNicSetting.md) to review the updated options and import logic.
* Refactored the `Checkpoint-ZertoVpg` command to allow pipeline input (ByValue and ByProperty) for the VpgName parameter.
* Corrected a parameter typo in the `Get-ZertoVpgSetting` function. The misspelt parameter was added as an alias to ensure any existing scripts using the parameter continue to function.
* Refactored the `Get-ZertoVpg` command to remove repetitive commands and variables that are no longer required.
