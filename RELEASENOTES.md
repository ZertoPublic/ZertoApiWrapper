

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
