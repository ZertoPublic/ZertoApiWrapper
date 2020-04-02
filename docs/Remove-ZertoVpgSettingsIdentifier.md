---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Resume-ZertoVpgSettingsIdentifier.md
schema: 2.0.0
---

# Remove-ZertoVpgSettingsIdentifier

## SYNOPSIS
When a new VpgSettingsIdentifier is created, all the settings sit in memory for 30 minutes after the last change. This operation will delete the settings from memory and discard any changes. This is akin to clicking cancel on the VPG Edit Wizard screen.

## SYNTAX

```
Remove-ZertoVpgSettingsIdentifier [-vpgSettingsIdentifier] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
When a new VpgSettingsIdentifier is created, all the settings sit in memory for 30 minutes after the last change. This operation will delete the settings from memory and discard any changes. This is akin to clicking cancel on the VPG Edit Wizard screen.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-ZertoVpgSettingsIdentifier -vpgSettingsIdentifier "1234-7890-5678"
```

Removes VPG Settings Identifier "1234-7890-5678" from the Zerto Virtual Manager without applying any settings that may have changed.

## PARAMETERS

### -vpgSettingsIdentifier
Settings Identifier to Remove

```yaml
Type: String[]
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

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Rest API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.118.html%23)
