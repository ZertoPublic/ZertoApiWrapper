---
external help file: ZertoFunctions-help.xml
Module Name: ZertoFunctions
online version:
schema: 2.0.0
---

# Get-Alerts

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-Alerts [<CommonParameters>]
```

### alertId
```
Get-Alerts -alertId <String[]> [<CommonParameters>]
```

### entities
```
Get-Alerts [-entities] [<CommonParameters>]
```

### helpIdentifiers
```
Get-Alerts [-helpIdentifiers] [<CommonParameters>]
```

### levels
```
Get-Alerts [-levels] [<CommonParameters>]
```

### filter
```
Get-Alerts [-startDate <String>] [-endDate <String>] [-vpgIdentifier <String>] [-siteIdentifier <String>]
 [-zorgIdentifier <String>] [-level <String>] [-helpIdentifier <String>] [-entity <String>] [-isDismissed]
 [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -alertId
{{Fill alertId Description}}

```yaml
Type: String[]
Parameter Sets: alertId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -endDate
{{Fill endDate Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entities
{{Fill entities Description}}

```yaml
Type: SwitchParameter
Parameter Sets: entities
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entity
{{Fill entity Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -helpIdentifier
{{Fill helpIdentifier Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -helpIdentifiers
{{Fill helpIdentifiers Description}}

```yaml
Type: SwitchParameter
Parameter Sets: helpIdentifiers
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -isDismissed
{{Fill isDismissed Description}}

```yaml
Type: SwitchParameter
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -level
{{Fill level Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -levels
{{Fill levels Description}}

```yaml
Type: SwitchParameter
Parameter Sets: levels
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifier
{{Fill siteIdentifier Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -startDate
{{Fill startDate Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgIdentifier
{{Fill vpgIdentifier Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zorgIdentifier
{{Fill zorgIdentifier Description}}

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
