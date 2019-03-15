# ZertoApiWrapper

PowerShell Core wrapper for Zerto Virtual Manager API

## Legal Disclaimer

This script is an example script and is not supported under any Zerto support program or service. The author and Zerto further disclaim all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose.

In no event shall Zerto, its authors or anyone else involved in the creation, production or delivery of the scripts be liable for any damages whatsoever (including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) arising out of the use of or the inability to use the sample scripts or documentation, even if the author or Zerto has been advised of the possibility of such damages. The entire risk arising out of the use or performance of the sample scripts and documentation remains with you.

## Disclaimer

This code is still under development!! USE AT YOUR OWN RISK AND ONLY IF YOU KNOW WHAT YOU ARE DOING!!

## Getting Started

Place the folder and contents on your hard drive in a location known to you. From there run the following command to import the module into your session:

```PowerShell
PS C:\>Import-Module <path>\ZertoApiWrapper\ZertoApiWrapper\ZertoApiWrapper.psm1 -force
```

This will import the module into your current session and make the function available to you use and test.

### Connecting to a ZVM

Before any of the functions will work, you will need to connect to a Zerto Virtual Manager server. To do this you will use the `Connect-ZertoServer` function passing in a Server Name or IP address of the Zerto Virtual Manager. If you are using a non-standard port, you will need to provide that as well with the `-zertoPort` parameter. You will also need to supply credentials to authenticate against the Zerto Virtual Manager. If credentials are not provided, the user will be prompted for a username and password.

```PowerShell
PS C:\>$credential = Get-Credential
PS C:\>Connect-ZertoServer -zertoServer "192.168.222.20" -credential $credential
```

After successful execution, a few Module level variables are set that are not currently exposed. These variables keep track of the Zerto Server connection information such as Server Name and Port information along with the authentication headers. A "Last Action" variable is also set to keep track of when the last call was made to the API to determine if the authentication information has expired or not. Should this command be run again with a different server, the old information will be overwritten and all commands from that point will be executed against the new server information.

### Using the Module

A help system is currently under development. While each command has a help page, it may not be fully fleshed out yet. To see all possible functions you can use the following command after the module has been imported:

```PowerShell
PS C:\>Get-Command -module ZertoApiWrapper
```

Once you have found the command that you want to know about you can call `Get-Help <Command>` to take a look at the help page, or if you want to see syntax, `Get-Command <Command> -syntax`.

### Ending the Session

If you are using this as part of a larger script, I highly suggest explicitly ending your session with the `Disconnect-ZertoSession` command. This will delete the token authorization from the Zerto Virtual Manager as well as clear all Module scoped variables.

## Recent Updates

- March 15th, 2019: Implement Export and Import Functionality. Please See [Export-ZertoVpg Help](https://github.com/wcarroll/ZertoApiWrapper/blob/Master/docs/Export-ZertoVpg.md) and [Import-ZertoVpg Help](https://github.com/wcarroll/ZertoApiWrapper/blob/ExportImportFunctionality/docs/Import-ZertoVpg.md) for assistance. No current pre-seed support.
- March 11th, 2019: Create basic VPG completed. Please see [New-ZertoVpg Help](https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/New-ZertoVpg.md)

## TODO

- Complete Help Markdown Files
- JFLR Functionality
- Create VPG (Per-VM modification and Backup Settings)
- Edit VPG
- Delete Zerto License
- Flesh out Pester Tests
- Complete Automated Build Process
