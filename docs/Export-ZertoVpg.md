---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Export-ZertoVpg

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### namedVpgs
```
Export-ZertoVpg -outputFolder <String> [-vpgName <String[]>] [<CommonParameters>]
```

### allVpgs
```
Export-ZertoVpg -outputFolder <String> [-allVpgs] [<CommonParameters>]
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

### -allVpgs
Export all VPGs at this site

```yaml
Type: SwitchParameter
Parameter Sets: allVpgs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -outputFolder
Location where to dump the resulting JSON files containing the VPG Settings

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name(s) of the VPG(s) to be exported

```yaml
Type: String[]
Parameter Sets: namedVpgs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
