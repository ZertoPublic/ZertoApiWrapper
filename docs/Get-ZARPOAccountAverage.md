---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Get-ZARPOAccountAverage.md
schema: 2.0.0
---

# Get-ZARPOAccountAverage

## SYNOPSIS

Get average RPO for all VPGs in a single account, filtered by last 30 days.

## SYNTAX

```
Get-ZARPOAccountAverage [[-zOrgIdentifier] <String>] [[-startDate] <String>] [[-endDate] <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Get average RPO for all VPGs in a single account, filtered by last 30 days.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZARPOAccountAverage
```

Get average RPO for all VPGs in a single account.

### Example 2
```powershell
PS C:\> Get-ZARPOAccountAverage -zOrgIdentifier "1234-5678-9012"
```

Get average RPO for all VPGs in zOrg with identifier "1234-5678-9012".

### Example 3
```powershell
PS C:\> Get-ZARPOAccountAverage -startDate "2019-06-01T00:00:00Z" -endDate "2019-06-02T00:00:00Z"
```

Get average RPO for all VPGs in a single account for June 6th, 2019

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

### -zOrgIdentifier
The ZORG identifier by which to filter the user's average RPO for a single account.
If the ZORG identifier is omitted, statistics related to all sites, for a single account, is retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Account RPO Average](https://docs.api.zerto.com/#/RPO_Reports/get_v2_reports_account_rpo_average)
