

### Zerto Virtual Manager

* Addressed a reported [issue](https://github.com/ZertoPublic/ZertoApiWrapper/issues/60) in the `Get-ZertoRecoveryReport` function where the `-VpgIdentifier` parameter was not working. This parameter is not accepted by the API as a valid filter and is ignored. This parameter has been removed from the function.
