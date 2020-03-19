---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerNetworkPerformanceReport.md
schema: 2.0.0
---

# Get-ZAPlannerNetworkPerformanceReport

## SYNOPSIS
Create a report request to retrieve the Network Performance for a specific VMs list, and timeframe.


## SYNTAX

```
Get-ZAPlannerNetworkPerformanceReport [-siteIdentifier] <String> [-recoveryType] <String>
 [-vmIdentifier] <String[]> [[-interval] <Int32>] [[-startDate] <String>] [[-endDate] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Create a report request to retrieve the Network Performance for a specific VMs list, and timeframe.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAPlannerNetworkPerformanceReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2'
```

Gets a Network Performance report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. This will use all data contained in Zerto Analytics to create the Journal report.

### Example 2
```powershell
PS C:\> Get-ZAPlannerNetworkPerformanceReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2' -startDate '2020-01-01' -interval 86400
```

Gets a Network Performance report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. This will use data contained in Zerto Analytics starting Jan 1st, 2020 ending on the day the report is run to create the Journal report. Sample reporting interval will be 86400 seconds (1 day).

### Example 3
```powershell
PS C:\> Get-ZAPlannerNetworkPerformanceReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2' -startDate '2020-01-01' -endDate '2020-01-30' -interval 86400
```

Gets a Network Performance report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. This will use data contained in Zerto Analytics starting Jan 1st, 2020 ending on Jan 30th, 2020 to create the Journal report. Sample reporting interval will be 86400 seconds (1 day).

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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -interval
The desired sample interval in seconds.
The default is 3600 seconds (1 Hour).
Limited to a 60 second to 86,400 second (24 Hour) interval

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 3600
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
[Zerto Analytics Planner Network-Performance API Endpoint - POST](https://docs.api.zerto.com/#/Planner/post_v2_planner_reports_network_performance)
[Zerto Analytics Planner Network-Performance API Endpoint - GET](https://docs.api.zerto.com/#/Planner/get_v2_planner_reports_network_performance)

