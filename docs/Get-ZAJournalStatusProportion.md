---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAJournalStatusProportion.md
schema: 2.0.0
---

# Get-ZAJournalStatusProportion

## SYNOPSIS

Retrieves journal history SLA status distribution over selected timeframe.

## SYNTAX

```
Get-ZAJournalStatusProportion [-vpgIdentifier] <String> [[-startDate] <String>] [[-endDate] <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves journal history SLA status distribution over selected timeframe.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAJournalStatusProportion -vpgIdentifier "9876-5432-1098"
```

Returns Journal history SLA status distribution for VPG with identifier "9876-5432-1098"

### Example 2
```powershell
PS C:\> Get-ZAJournalStatusProportion -vpgIdentifier "9876-5432-1098" -startDate "2019-06-01" -endDate "2019-06-08"
```

Returns Journalhistory SLA status distribution for VPG with identifier "9876-5432-1098" between the dates specified.

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

[Zerto Analytics REST API Endpoint for Journal Statuses Proportions](https://docs.api.zerto.com/#/Journal_Reports/get_v2_reports_journal_statuses_proportions)
