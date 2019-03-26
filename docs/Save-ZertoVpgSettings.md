---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Save-ZertoVpgSettings.md
schema: 2.0.0
---

# Save-ZertoVpgSettings

## SYNOPSIS
Commits the updated Vpg Settings with the configured Vpg Settings Identifier

## SYNTAX

```
Save-ZertoVpgSettings [-vpgSettingsIdentifier] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Commits the updated Vpg Settings with the configured Vpg Settings Identifier

## EXAMPLES

### Example 1
```powershell
PS C:> Save-ZertoVpgSettings -vpgSettingsIdentifier "MyVpgSettingsIdentifier"
```

Commits vpg settings with vpg settings identifier "MyVpgSettingsIdentifier"

## PARAMETERS

### -vpgSettingsIdentifier
VpgSettings Identifier to save

```yaml
Type: String
Parameter Sets: (All)
Aliases: vpgSettingsId

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)
