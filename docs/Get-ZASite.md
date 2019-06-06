---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZASite.md
schema: 2.0.0
---

# Get-ZASite

## SYNOPSIS

Retrieve a list of all sites.

## SYNTAX

```
Get-ZASite [[-zOrgIdentifier] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieve a list of all sites.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZASite
```

Retrieve a list of all sites.

### Example 2
```powershell
PS C:\> Get-ZASite -zOrgIdentifier "1234-5678-9012"
```

Retrieve a list of all sites managed under zOrgIdentifier "1234-5678-9012".

## PARAMETERS

### -zOrgIdentifier
The ZORG identifier by which to filter site list.
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

[Zerto Analytics REST API Endpoint for Sites](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_sites)
