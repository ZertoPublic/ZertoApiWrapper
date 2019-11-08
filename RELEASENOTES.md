

### Zerto Virtual Manager

* [Zerto version 7.5 has been released.](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Release%20Notes.pdf) As part of this release Zerto has added API functionality that requires the following updates.
  * A token is now required to pair two sites together. The need is discussed in [Issue 46](https://github.com/ZertoPublic/ZertoApiWrapper/issues/46). To implement this change a `-token` parameter has been added to the `Add-ZertoPeerSite` function.
  * A new function has been added; `New-ZertoPairingToken`. This function will allow users to generate a pairing authentication token from the target ZVM to be used in the pairing process. [Issue 47](https://github.com/ZertoPublic/ZertoApiWrapper/issues/47) covers additional details.
  * A new function has been added; `Invoke-ZertoEvacuateVra`. This function will allow users to evacuate a target VRA by specifying a Host Name, VRA Name, or VRA Identifier. All VMs currently replicating to the specified location will be migrated to different targets. [Issue 51](https://github.com/ZertoPublic/ZertoApiWrapper/issues/51)
  * A function has been added; `Copy-ZertoVpg`. This function will allow users to copy the settings of a single VPG and add new VMs to it. There is currently no customization beyond specifying the VMs to be placed in the newly created VPG. Should additional edits \ updates be required, they should be done post creation. [Issue 54](https://github.com/ZertoPublic/ZertoApiWrapper/issues/54)

### Zerto Analytics

### General Updates
