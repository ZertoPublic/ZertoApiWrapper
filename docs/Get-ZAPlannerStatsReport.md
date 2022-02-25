---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerStatsReport.md
schema: 2.0.0
---

# Get-ZAPlannerStatsReport

## SYNOPSIS
Create a report request for the selected VMs for a specific timeframe, retrieving all stats data for ZCAs, WAN, Journal size and array of VMs avg IOPs, avg throughput and journal size.

## SYNTAX

```
Get-ZAPlannerStatsReport [-siteIdentifier] <String> [-recoveryType] <String> [-vmIdentifier] <String[]>
 [[-desiredJournalHistory] <Int32>] [[-startDate] <String>] [[-endDate] <String>] [<CommonParameters>]
```

## DESCRIPTION
Create a report request for the selected VMs for a specific timeframe, retrieving all stats data for ZCAs, WAN, Journal size and array of VMs avg IOPs, avg throughput and journal size.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAPlannerStatsReport -siteIdentifier '0123-45676-09876' -recoveryType vcenter -vmIdentifier 'vmIdentifier01', 'vmIdentifier02'
```

Will get a stats report for the two VMs listed recovering to a vCenter site with a 24 hour journal

### Example 2
```powershell
PS C:\> Get-ZAPlannerStatsReport -siteIdentifier '0123-45676-09876' -recoveryType Azure -vmIdentifier 'vmIdentifier01', 'vmIdentifier02' -desiredJournalHistory 72
```

Will get a stats report for the two VMs listed recovering to an Azure site with a 72 hour journal

## PARAMETERS

### -desiredJournalHistory
The desired journal history in hours.
The default is 24 hours.
Limited to a 1 hour up to 720 hours, or the equivalent of 30 days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 24
Accept pipeline input: False
Accept wildcard characters: False
```

### -endDate
The latest timestamp of an event to return, in RFC 3339 standard.
('1970-01-01T00:00:00Z').
The default is the current time.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 5
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

[Zerto Analytics Planner Stats API Endpoint - POST](https://docs.api.zerto.com/#/Planner/post_v2_planner_reports_stats)
[Zerto Analytics Planner Stats API Endpoint - GET](https://docs.api.zerto.com/#/Planner/get_v2_planner_reports_stats)
