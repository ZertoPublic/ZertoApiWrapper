---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAMonitoring.md
schema: 2.0.0
---

# Get-ZARPOSummary

## SYNOPSIS

Retrieves RPO historical statistics for a given VPG.

## SYNTAX

```
Get-ZARPOSummary [-vpgIdentifier] <String> [[-startDate] <String>] [[-endDate] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieves RPO historical statistics for a given VPG.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZARPOSummary -vpgIdentifier "3456-7890-1234"
```

Gets the RPO Summary for the VPG with identifier "3456-7890-1234" for the past 7 days.

### Example 2
```powershell
PS C:\> Get-ZARPOSummary -vpgIdentifier "3456-7890-1234" -startDate "2019-01-01T00:00:00"
```

Gets the RPO Summary for the VPG with identifier "3456-7890-1234" starting January 1st, 2019 till the date this command is run.

### Example 3
```powershell
PS C:\> Get-ZARPOSummary -vpgIdentifier "3456-7890-1234" -startDate "2019-01-01T00:00:00" -endDate "2019-02-01T00:00:00"
```

Gets the RPO Summary for the VPG with identifier "3456-7890-1234" for the Month of January.

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

[Zerto Analytics REST API Endpoint for RPO Summary](https://docs.api.zerto.com/#/RPO_Reports/get_v2_reports_rpo_summary)
