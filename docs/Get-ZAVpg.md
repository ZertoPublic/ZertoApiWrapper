---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAVpg.md
schema: 2.0.0
---

# Get-ZAVpg

## SYNOPSIS

Retrieve a list of all VPGs.

## SYNTAX

### zOrg (Default)
```
Get-ZAVpg [-zOrgIdentifier <String>] [<CommonParameters>]
```

### vpg
```
Get-ZAVpg -vpgIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION

Retrieve a list of all VPGs.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAVpg
```

Retrieve a list of all VPGs.

### Example 2
```powershell
PS C:\> Get-ZAVpg -zOrgIdentifier "1234-5678-9012"
```

Retrieve a list of all VPGs associated with zOrg "1234-5678-9012"

### Example 3
```powershell
PS C:\> Get-ZAVpg -vpgIdentifier "2109-8765-4321"
```

Retrieve information for VPG with identifier "2109-8765-4321"

## PARAMETERS

### -vpgIdentifier
The VPG Identifier

```yaml
Type: String
Parameter Sets: vpg
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zOrgIdentifier
The ZORG identifier by which to filter the VPG list.
If the ZORG identifier is omitted, a list of all VPGs is retrieved.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for VPGs](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_vpgs)
[Zerto Analytics REST API Endpoint for VPG Identifier](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_vpgs__vpgIdentifier_)
