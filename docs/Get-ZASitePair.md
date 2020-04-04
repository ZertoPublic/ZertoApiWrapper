---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZASitePair.md
schema: 2.0.0
---

# Get-ZASitePair

## SYNOPSIS

Get all the sites, protected and recovery, filtered by start date and end date.

## SYNTAX

```
Get-ZASitePair [[-zOrgIdentifier] <String>] [[-startDate] <String>] [[-endDate] <String>] [<CommonParameters>]
```

## DESCRIPTION

Get all the sites, protected and recovery, filtered by start date and end date.
* When startDate is omitted, the default startDate is 7 days before the endDate.
* When endDate is ommited, the default endDate is the current date.
* When both startDate and endDate are omitted, the default date range is the last 7 days.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZASitePair
```

Returns all site pairings.

### Example 1
```powershell
PS C:\> Get-ZASitePair -zOrgIdentifier "9876-5432-1098"
```

Returns all site pairings belonging to zOrg with Identifier "9876-5432-1098".

## PARAMETERS

### -endDate
End date in RFC 3339 standard ('1970-01-01T00:00:00Z').
If the end date is omitted, the default endDate is the current date.

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

### -zOrgIdentifier
The ZORG identifier by which to filter the site list.
If the ZORG identifier is omitted, a list of all sites is retrieved.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Site Pairs](https://docs.api.zerto.com/#/Network_Reports/get_v2_reports_sites_list)
