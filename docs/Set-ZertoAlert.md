---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Set-ZertoAlert.md
schema: 2.0.0
---

# Set-ZertoAlert

## SYNOPSIS
Dismisses or Undismisses a Zerto Alert

## SYNTAX

### dismiss
```
Set-ZertoAlert -alertId <String[]> [-dismiss] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### undismiss
```
Set-ZertoAlert -alertId <String[]> [-undismiss] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Dismisses or Undismisses a Zerto Alert

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-ZertoAlert -alertId "AlertId" -dismiss
```

Dismiss alert with alert identifier "AlertId"

### Example 2
```powershell
PS C:\> Set-ZertoAlert -alertId "AlertId" -undismiss
```

Undismiss alert with alert identifier "AlertId"

## PARAMETERS

### -alertId
Alert identifier(s) to be dismissed or undismissed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: alertIdentifier, identifier

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -dismiss
Will dismiss the selected alert.

```yaml
Type: SwitchParameter
Parameter Sets: dismiss
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -undismiss
Will undismiss the selected alert.

```yaml
Type: SwitchParameter
Parameter Sets: undismiss
Aliases:

Required: True
Position: Named
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

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Alerts End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.009.html%23)
