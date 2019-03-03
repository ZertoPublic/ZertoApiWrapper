# ZertoApiWrapper
PowerShell Core wrapper for Zerto Virtual Manager API

## Legal Disclaimer
This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.

## Getting Started
Place the folder and contents on your hard drive in a location known to you. From there run the following command to import the module into your session:
```PowerShell
PS C:\>Import-Module <path>\ZertoApiWrapper\ZertoApiWrapper\ZertoApiWrapper.psm1 -force
```

This will import the module into your current session and make the function avialable to you use and test.

### Connecting to a ZVM
Before any of the functions will work, you will need to connect to a Zerto Virtual Manager server. To do this you will use the `Connect-ZertoServer` function passing in a Server Name or IP address of the Zerto Virtual Manager. If you are using a non-standard port, you will need to provide that as well with the `-zertoPort` parameter. You will also need to supply credentials to authenticate against the Zerto Virtual Manager. If credentials are not provided, the user will be prompted for a username and password.
#### Example:
```PowerShell
PS C:\>$credential = Get-Credential
PS C:\>Connect-ZertoServer -zertoServer "192.168.222.20" -credential $credential
```
