---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoZsspSession.md
schema: 2.0.0
---

# Import-ZertoVmNicSetting

## SYNOPSIS
Using a CSV file, will import updated Live and Test network settings for protected virtual machines.

## SYNTAX

```
Import-ZertoVmNicSetting [-InputFile] <String> [<CommonParameters>]
```

## DESCRIPTION
Using a CSV file, will import updated Live and Test network settings for protected virtual machines. This function will read the provided CSV file and only update VMs defined in the file.

It should be noted, due to current API limitations once a NIC is defined to update to either a Static IP address or use a DHCP address, it is not possible to remove that configuration via the API. Should you require this functionality, you will need to manually update via the GUI to set the option to "No"

## EXAMPLES

### Example 1
```powershell
PS C:\> Import-ZertoVmNicSetting -InputFile 'C:\ZertoScripts\UpdatedNicInformation.csv'
```

Imports the data in the CSV located at 'C:\ZertoScripts\UpdatedNicInformation.csv' and updates each VM and each NIC as defined in the CSV file.

## PARAMETERS

### -InputFile
File to process for import

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
[Zerto Virtual Manager REST API VpgSettings end point documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.110.html%23)
