---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZANetworkVpgAverageIOPS.md
schema: 2.0.0
---

# Get-ZANetworkVpgAverageIOPS

## SYNOPSIS

Get average and maximum IOPS performance for a specific VPG, filtered by start date and end date, and optional intervals.

## SYNTAX

```
Get-ZANetworkVpgAverageIOPS [-vpgIdentifier] <String> [[-startDate] <String>] [[-endDate] <String>]
 [[-interval] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Get average and maximum IOPS performance for a specific VPG, filtered by start date and end date, and optional intervals.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZANetworkVpgAverageIOPS -vpgIdentifier "3456-7890-1234" -interval 3600
```

Get Network VPG Average IOPS for VPG with Identifier "3456-7890-1234" for the last 7 days at an interval of 1 hour.

## PARAMETERS

### -endDate
End date in RFC 3339 standard ('1970-01-01T00:00:00Z').
If the end date is omitted, the default end date is the current time.

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
The interval selected within the duration of the report. The interval can be per minute - for up to 6 hours, per hour - for 6 hours to 15 days, or per day - for 15 days up to 30 days. If an interval is not specified, the default is 60 seconds. Submit value in Seconds.

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
Start date in RFC 3339 standard ('1970-01-01T00:00:00Z').
If the start date is omitted, the default start date is 7 days before the end date.

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
The VPG identifier.

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

[Zerto Analytics REST API Endpoint for Network VPG Average IOPS](https://docs.api.zerto.com/#/Network_Reports/get_v2_reports_vpg_network_iops_average)
