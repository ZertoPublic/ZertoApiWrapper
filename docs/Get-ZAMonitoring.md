---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAMonitoring.md
schema: 2.0.0
---

# Get-ZAMonitoring

## SYNOPSIS

Retrieve statistics related to all the user's sites - belonging to a single account.

## SYNTAX

```
Get-ZAMonitoring [[-zOrgIdentifier] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieve statistics related to all the user's sites - belonging to a single account.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAMonitoring
```

Retrieve statistics related to all the user's sites - belonging to a single account.

### Example 1
```powershell
PS C:\> Get-ZAMonitoring -zOrgIdentifier "1234-5678-9012"
```

Retrieve statistics related to the zOrgIdentifier provided

## PARAMETERS

### -zOrgIdentifier
The ZORG identifier by which to filter the user's statistics for a single account.
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Monitoring](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_)
