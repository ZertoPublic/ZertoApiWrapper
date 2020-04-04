---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAJournalSiteAverageHistory.md
schema: 2.0.0
---

# Get-ZAJournalSiteAverageHistory

## SYNOPSIS

Get list of samples of average Journal History values for all VPGs replicating to a specified recovery site, filtered by start date, end date, and optional interval. The interval defines the Journal History samples interval.

## SYNTAX

```
Get-ZAJournalSiteAverageHistory [-recoverySiteIdentifier] <String> [[-startDate] <String>]
 [[-endDate] <String>] [[-interval] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Get list of samples of average Journal History values for all VPGs replicating to a specified recovery site, filtered by start date, end date, and optional interval. The interval defines the Journal History samples interval.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAJournalSiteAverageHistory -recoverySiteIdentifier "9876-5432-1098"
```

Returns Journal Average History information for the recovery site with identifier "9876-5432-1098"

### Example 2
```powershell
PS C:\> Get-ZAJournalSiteAverageHistory -recoverySiteIdentifier "9876-5432-1098" -startDate "2019-06-01" -endDate "2019-06-08"
```

Returns Journal Average History information for the recovery site with identifier "9876-5432-1098" between the dates specified.

### Example 3
```powershell
PS C:\> Get-ZAJournalSiteAverageHistory -recoverySiteIdentifier "9876-5432-1098" -startDate "2019-06-01" -endDate "2019-06-08" -interval 7200
```

Returns Journal Average History information for the recovery site with identifier "9876-5432-1098" between the dates specified with a 2 hour interval.

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
The interval selected within the duration of the report. The interval can be per hour, for up to 15 days' time frame or per day, for between 15 to 30 days' time frame. Submit value in Seconds

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

### -recoverySiteIdentifier
The identifier of the recovery site.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Journal Average Site History](https://docs.api.zerto.com/#/Journal_Reports/get_v2_reports_site_journal_history_average)
