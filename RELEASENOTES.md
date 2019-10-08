

### Zerto Virtual Manager

* [Zerto version 7.5 has been released.](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Release%20Notes.pdf) As part of this release Zerto has added API functionality that requires the following updates.
  * A token is now required to pair two sites together. The need is discussed in [Issue 46](https://github.com/ZertoPublic/ZertoApiWrapper/issues/46). To implement this change a `-token` parameter has been added to the `Add-ZertoPeerSite` function.
  * A new function has been added; `New-ZertoPairingToken`. This function will allow users to generate a pairing authentication token from the target ZVM to be used in the pairing process. [Issue 47](https://github.com/ZertoPublic/ZertoApiWrapper/issues) covers additional details.

### Zerto Analytics

### General Updates
