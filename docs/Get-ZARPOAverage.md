---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Get-ZARPOAverage.md
schema: 2.0.0
---

# Get-ZARPOAverage

## SYNOPSIS

Retrieves list of average RPO values for a specific VPG, filtered by start date, end date, and optional interval. The interval defines the RPO samples interval. by default a 1 minutes interval.

## SYNTAX

```
Get-ZARPOAverage [-vpgIdentifier] <String> [[-startDate] <String>] [[-endDate] <String>] [[-interval] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves list of average RPO values for a specific VPG, filtered by start date, end date, and optional interval. The interval defines the RPO samples interval. by default a 1 minutes interval.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZARPOAverage -vpgIdentifier "5678-9012-3456"
```

Returns RPO Average over the past 7 days for VPG with Identifier "5678-9012-3456"

### Example 2
```powershell
PS C:\> Get-ZARPOAverage -vpgIdentifier "5678-9012-3456" -startDate "2019-06-01T12:00:00Z" -endDate "2019-06-01T14:00:00Z" -interval 60
```

Returns RPO Average in one minute intervals for the time period between June 1st, 2019 at Noon to June 1st, 2019 at 14:00 for VPG with Identifier "5678-9012-3456"

## PARAMETERS

### -endDate
The end date of the report, in RFC 3339 standard ('1970-01-01T00:00:00Z').
The default is the current time.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -interval
The interval selected within the duration of the report.
The interval can be 1-minute data granularity for up to 6 hours' time frame, 1-hour data granularity for 6 hours to 15 days' time frame or 1-day data granularity for 15 days up to 30 days' time frame.
Value should be submitted in Seconds

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -startDate
The starting date of the report, in RFC 3339 standard ('1970-01-01T00:00:00Z').
If only the end date is added, the start date by default will be the end date minus 7 days.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgIdentifier
The identifier of the VPG.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for RPO Average](https://docs.api.zerto.com/#/RPO_Reports/get_v2_reports_rpo_average)
