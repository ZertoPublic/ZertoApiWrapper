---
external help file: ZertoFunctions-help.xml
Module Name: ZertoFunctions
online version:
schema: 2.0.0
---

# Get-Tasks

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-Tasks [<CommonParameters>]
```

### taskIdentifier
```
Get-Tasks [-taskIdentifier <String[]>] [<CommonParameters>]
```

### types
```
Get-Tasks [-types] [<CommonParameters>]
```

### filter
```
Get-Tasks [-startedBeforeDate <String>] [-startedAfterDate <String>] [-completedAfterDate <String>]
 [-completedBeforeDate <String>] [-type <String>] [-status <String>] [<CommonParameters>]
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

### -completedAfterDate
{{Fill completedAfterDate Description}}

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

### -completedBeforeDate
{{Fill completedBeforeDate Description}}

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

### -startedAfterDate
{{Fill startedAfterDate Description}}

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

### -startedBeforeDate
{{Fill startedBeforeDate Description}}

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

### -status
{{Fill status Description}}

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

### -taskIdentifier
{{Fill taskIdentifier Description}}

```yaml
Type: String[]
Parameter Sets: taskIdentifier
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{Fill type Description}}

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

### -types
{{Fill types Description}}

```yaml
Type: SwitchParameter
Parameter Sets: types
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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
