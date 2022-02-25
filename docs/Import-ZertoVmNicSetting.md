---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Import-ZertoVmNicSetting.md
schema: 2.0.0
---

# Import-ZertoVmNicSetting

## SYNOPSIS
Using a CSV file, will import updated Live and Test network settings for protected virtual machines.

## SYNTAX

```
Import-ZertoVmNicSetting [-InputFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Using a CSV file, will import updated Live and Test network settings for protected virtual machines. This function will read the provided CSV file and only update VMs defined in the file.

Each entry in the CSV will be for one VM and a single NIC attached to that VM. Each entry MUST contain the following information: VPG Name, VM Name, Network Adapter Name, Mac Address Update for both Live and Test, and Network Name for both Live and Test. All other information is optional, but will be applied based on the following logic:
  * If 'IsDhcp' is set to 'TRUE', the NIC setting will be set to DHCP and Primary DNS, Secondary DNS, and Search Domain settings will be applied along with the mandatory fields.
  * If 'IsDhcp' is set to 'FALSE' or not set and there is an IP Address defined, the IP Address, Subnet Mask, Default Gateway, Primary DNS, Secondary DNS, and Search Domain settings will be applied along with the mandatory fields.
  * if 'IsDhcp' is set to 'FALSE' or not set and there is NOT an IP Address defined, the current NIC settings will be removed and ONLY the mandatory fields will be applied.

This logic is applied to both the Live and Test settings individually. It is recommended to use the `Export-ZertoVpgNicSetting` to dump all current settings and then modify a copy of the exported file with only the settings you wish to update. Import the copied file and if you need to revert, Import the original.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
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
