---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/Master/docs/New-ZertoVpgSettingsIdentifier.md
schema: 2.0.0
---

# New-ZertoVpgSettingsIdentifier

## SYNOPSIS
Creates and returns a VPG Settings Identifier either for an existing VPG or a new VPG.

## SYNTAX

### existingVpg
```
New-ZertoVpgSettingsIdentifier -vpgIdentifier <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### newVpg
```
New-ZertoVpgSettingsIdentifier [-newVpg] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates and returns a VPG Settings Identifier either for an existing VPG or a new VPG.

## EXAMPLES

### Example 1
```powershell
PS C:> New-ZertoVpgSettingsIdentifier -newVpg
```

Creates a Vpg Settings Identifier for a new, blank VPG.

### Example 2
```powershell
PS C:> New-ZertoVpgSettingsIdentifier -vpgIdentifier "MyVpgIdentifier"
```

Creates a Vpg Settings Identifier for an existing VPG. This settings identifier points to a settings object that contains the current settings of the VPG.

## PARAMETERS

### -newVpg
Use this switch when creating a vpgSettingsIdentifier for a new VPG

```yaml
Type: SwitchParameter
Parameter Sets: newVpg
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgIdentifier
Identifier of the VPG to create a VPG settings identifier.
If a vpgIdentifier is not provided, a new VPG settings object is created without any configured settings.
This would be used for creating a new VPG from scratch.

```yaml
Type: String
Parameter Sets: existingVpg
Aliases: vpgId

Required: True
Position: Named
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)
