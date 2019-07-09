

### Zerto Virtual Manager

* Added two functions to aid in bulk updating of NIC information for protected VMs. ([Issue 38](https://github.com/ZertoPublic/ZertoApiWrapper/issues/38))
  * [Export-ZertoVmNicSetting](https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Export-ZertoVmNicSettings.md)
  * [Import-ZertoVmNicSetting](https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Import-ZertoVmNicSettings.md)

### Zerto Analytics

* Fixed an [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/36) where the Zerto Analytics Rest Request function was not checking for the token before attempting a connection.
