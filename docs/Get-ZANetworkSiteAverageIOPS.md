---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZANetworkSiteAverageIOPS.md
schema: 2.0.0
---

# Get-ZANetworkSiteAverageIOPS

## SYNOPSIS

Get average and maximum IOPS performance for sites, filtered by start date and end date, and optional intervals.

## SYNTAX

### ProtectedSite (Default)
```
Get-ZANetworkSiteAverageIOPS -protectedSiteIdentifier <String> [-recoverySiteIdentifier <String>]
 [-startDate <String>] [-endDate <String>] [-zOrgIdentifier <String>] [<CommonParameters>]
```

### RecoverySite
```
Get-ZANetworkSiteAverageIOPS [-protectedSiteIdentifier <String>] -recoverySiteIdentifier <String>
 [-startDate <String>] [-endDate <String>] [-zOrgIdentifier <String>] [<CommonParameters>]
```

## DESCRIPTION

Get average and maximum IOPS performance for sites, filtered by start date and end date, and optional intervals.
The following options are available:

* To view average and maximum IOPS performance of all outgoing traffic from a protected site to all its replicating sites, specify only the protected site identifier.
* To view average and maximum IOPS performance between two sites, specify both the protected site identifier and the recovery site identifier.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZANetworkSiteAverageIOPS -protectedSiteIdentifier "7890-1234-5678"
```

Returns outgoing networks IOPS average from site with identifier "7890-1234-5678"

### Example 2
```powershell
PS C:\> Get-ZANetworkSiteAverageIOPS -protectedSiteIdentifier "7890-1234-5678" -recoverySiteIdentifier "9876-5432-1098"
```

Returns network IOPS average between sites with identifiers "7890-1234-5678" and "9876-5432-1098"

## PARAMETERS

### -endDate
End date in RFC 3339 standard ('1970-01-01T00:00:00Z').
If the end date is omitted, the default end date is the current time.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -protectedSiteIdentifier
Protected site identifier.
A site identification is required for at least one of the sites.

```yaml
Type: String
Parameter Sets: ProtectedSite
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: RecoverySite
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoverySiteIdentifier
Recovery site identifier.
If the recovery site identifier is omitted, the API will show all outgoing traffic from the protected site to its replicating sites.

```yaml
Type: String
Parameter Sets: ProtectedSite
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: RecoverySite
Aliases:

Required: True
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zOrgIdentifier
The ZORG identifier by which to filter the executive summary.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

[Zerto Analytics REST API Endpoint for Network Site Average IOPS](https://docs.api.zerto.com/#/Network_Reports/get_v2_reports_sites_network_iops_average)
