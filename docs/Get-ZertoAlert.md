---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoAlert

## SYNOPSIS
Get Alerts from the Zerto Virtual Manager

## SYNTAX

### main (Default)
```
Get-ZertoAlert [<CommonParameters>]
```

### alertId
```
Get-ZertoAlert -alertId <String[]> [<CommonParameters>]
```

### entities
```
Get-ZertoAlert [-entities] [<CommonParameters>]
```

### helpIdentifiers
```
Get-ZertoAlert [-helpIdentifiers] [<CommonParameters>]
```

### levels
```
Get-ZertoAlert [-levels] [<CommonParameters>]
```

### filter
```
Get-ZertoAlert [-startDate <String>] [-endDate <String>] [-vpgIdentifier <String>] [-siteIdentifier <String>]
 [-zorgIdentifier <String>] [-level <String>] [-helpIdentifier <String>] [-entity <String>]
 [-isDismissed <Boolean>] [<CommonParameters>]
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
AlertId or array of AlertIds to be queried

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
Returns Alerts before the End Date.
Provide the string in the format of 'yyyy-MM-ddTHH:mm:ss.fff'

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
Switch to return the entities information from the API

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
Returns alerts for the specified entity

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
Returns alerts for the specified helpIdentifier

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
Switch to get the Help Identifiers information from the API

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
Returns alerts that are dismissed when set to $true an undismissed alerts when set to $false

```yaml
Type: Boolean
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -level
Returns alerts for the specified level

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
Switch to return Alert Levels information from the API

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
Returns alerts for the specified siteIdentifier

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
Returns Alerts after the Start Date.
Provide the string in the format of 'yyyy-MM-ddTHH:mm:ss.fff'

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
Returns alerts for the specified vraIdentifier

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
Returns alerts for the specified zorgIdentifier

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
