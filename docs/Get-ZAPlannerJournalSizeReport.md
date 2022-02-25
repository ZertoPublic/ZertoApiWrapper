---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAPlannerJournalSizeReport.md
schema: 2.0.0
---

# Get-ZAPlannerJournalSizeReport

## SYNOPSIS
Create a report request to retrieve the Journal Size for a specific VMs list, and timeframe.

## SYNTAX

```
Get-ZAPlannerJournalSizeReport [-siteIdentifier] <String> [-recoveryType] <String> [-vmIdentifier] <String[]>
 [[-desiredJournalHistory] <Int32>] [[-startDate] <String>] [[-endDate] <String>] [<CommonParameters>]
```

## DESCRIPTION
Create a report request to retrieve the Journal Size for a specific VMs list, and timeframe.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAPlannerJournalSizeReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2'
```

Gets a Journal report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. The report will cover a Journal History of 24 hours. This will use all data contained in Zerto Analytics to create the Journal report.

### Example 2
```powershell
PS C:\> Get-ZAPlannerJournalSizeReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2' -desiredJournalHistory 96
```

Gets a Journal report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. The report will cover a Journal History of 96 hours (4 days). This will use all data contained in Zerto Analytics to create the Journal report.

### Example 3
```powershell
PS C:\> Get-ZAPlannerJournalSizeReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2' -desiredJournalHistory 96 -startDate '2020-01-01'
```

Gets a Journal report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. The report will cover a Journal History of 96 hours (4 days). This will use all data starting from Jan 1st to today contained in Zerto Analytics to create the Journal report.

### Example 4
```powershell
PS C:\> Get-ZAPlannerJournalSizeReport -siteIdentifier '1234567890-01923141' -recoveryType VMware -vmIdentifier 'vmIdentifier1', 'vmIdentifier2' -desiredJournalHistory 96 -startDate '2020-01-01' -endDate '2020-01-30'
```

Gets a Journal report for VMs with identifiers 'vmIdentifier1' and 'vmIdentifier2' at source siteIdentifier '1234567890-01923141' where the target recovery location is VMware. The report will cover a Journal History of 96 hours (4 days). This will use all data starting from Jan 1st to Jan 30th contained in Zerto Analytics to create the Journal report.

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

[Zerto Planner Journal Size Report - Post](https://docs.api.zerto.com/#/Planner/post_v2_planner_reports_stats_journal_size)
[Zerto Planner Journal Size Report - Get](https://docs.api.zerto.com/#/Planner/get_v2_planner_reports_stats_journal_size)
