---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAAlert.md
schema: 2.0.0
---

# Get-ZAAlert

## SYNOPSIS
Retrieve information about all existing alerts.

## SYNTAX

### zOrg (Default)
```
Get-ZAAlert [-zOrgIdentifier <String>] [-limitTo <Int32>] [<CommonParameters>]
```

### alertId
```
Get-ZAAlert -alertIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieve information about all existing alerts.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAAlert
```

Returns all alerts.

### Example 2
```powershell
PS C:\> Get-ZAAlert -limitTo 10
```

Returns 10 alerts.

### Example 3
```powershell
PS C:\> Get-ZAAlert -zOrgIdentifier "1234-5678-9012"
```

Returns all alerts for the zOrg with Identifier "1234-5678-9012".

### Example 4
```powershell
PS C:\> Get-ZAAlert -zOrgIdentifier "1234-5678-9012" -limitTo 10
```

Returns 10 alerts for the zOrg with Identifier "1234-5678-9012".

### Example 3
```powershell
PS C:\> Get-ZAAlert -alertId "1234-5678-9012"
```

Returns one alert with identifier "1234-5678-9012".

## PARAMETERS

### -alertIdentifier
The VPG Idnetifier

```yaml
Type: String
Parameter Sets: alertId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limitTo
The maximum number of alerts to return.

```yaml
Type: Int32
Parameter Sets: zOrg
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -zOrgIdentifier
The ZORG identifier by which to filter the alert list.
If the ZORG identifier is omitted, a list of all the alerts is retrieved.

```yaml
Type: String
Parameter Sets: zOrg
Aliases:

Required: False
Position: Named
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

[Zerto Analytics REST API Endpoint for Alerts](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_alerts)
[Zerto Analytics REST API Endpoint for Alerts by Identifier](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_alerts__alertIdentifier_)
