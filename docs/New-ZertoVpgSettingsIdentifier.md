---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# New-ZertoVpgSettingsIdentifier

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### existingVpg
```
New-ZertoVpgSettingsIdentifier -vpgIdentifier <String> [<CommonParameters>]
```

### newVpg
```
New-ZertoVpgSettingsIdentifier [-newVpg] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:> {{ Add example code here }}
```

{{ Add example description here }}

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
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
