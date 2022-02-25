---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerZcasReport.md
schema: 2.0.0
---

# Get-ZAPlannerZcasReport

## SYNOPSIS
Create a report request to retrieve ZCAs for a specific VMs list, and timeframe.

## SYNTAX

```
Get-ZAPlannerZcasReport [-siteIdentifier] <String> [-recoveryType] <String> [-vmIdentifier] <String[]>
 [[-startDate] <String>] [[-endDate] <String>] [<CommonParameters>]
```

## DESCRIPTION
Create a report request to retrieve ZCAs for a specific VMs list, and timeframe.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAPlannerZcasReport -siteIdentifier '12345-0987654-254364' -recoveryType azure -vmIdentifier '1234-98789-0987', '1234-98789-1252'
```

Get a report for the number of required ZCA's in Azure to protect the supplied VMs.

## PARAMETERS

### -endDate
The latest timestamp of an event to return, in RFC 3339 standard.
('1970-01-01T00:00:00Z').
The default is the current time.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoveryType
Type of target recovery site.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifier
The site identifier(s) for which to return detailed information.

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

### -startDate
The earliest timestamp of an event to return, in RFC 3339 standard.
('1970-01-01T00:00:00Z').
The default is one year ago.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vmIdentifier
Identifiers of the VMs you want to recover at the target recovery site.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[Zerto Analytics Planner ZCA Stats API Endpoint - POST](https://docs.api.zerto.com/#/Planner/post_v2_planner_reports_stats_zcas)
[Zerto Analytics Planner ZCA Stats API Endpoint - GET](https://docs.api.zerto.com/#/Planner/get_v2_planner_reports_stats_zcas)
