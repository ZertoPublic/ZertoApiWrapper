---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZANetworkVpgStat.md
schema: 2.0.0
---

# Get-ZANetworkVpgStat

## SYNOPSIS

Get Max, Avg. and Min network statistics for Throughput, Wan and IOPS traffic for a given VPG, filtered by start date and end date.

## SYNTAX

```
Get-ZANetworkVpgStat [-vpgIdentifier] <String> [[-startDate] <String>] [[-endDate] <String>]
 [<CommonParameters>]
```

## DESCRIPTION

Get Max, Avg. and Min network statistics for Throughput, Wan and IOPS traffic for a given VPG, filtered by start date and end date.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZANetworkVpgStat -vpgIdentifier "3456-7890-1234"
```

Get Network VPG Stats for VPG with Identifier "3456-7890-1234" for the last 7 days.

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

[Zerto Analytics REST API Endpoint for Network VPG Summary](https://docs.api.zerto.com/#/Network_Reports/get_v2_reports_vpg_network_summary)
