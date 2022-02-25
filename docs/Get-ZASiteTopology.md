---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZASiteTopology.md
schema: 2.0.0
---

# Get-ZASiteTopology

## SYNOPSIS

Retrieves a collection of Sites topology information structures for all the available user's sites, including disabled and non-transmitting due to lack of a transmitter (older ZVR versions).

## SYNTAX

```
Get-ZASiteTopology [[-zOrgIdentifier] <String>] [<CommonParameters>]
```

## DESCRIPTION

Retrieves a collection of Sites topology information structures for all the available user's sites, including disabled and non-transmitting due to lack of a transmitter (older ZVR versions). | The following note should be taken into consideration:
The information might not be complete, since there are sites that do not transmit (disabled), yet this API concludes their presence and VPG count from the VPGs they share with transmitting sites. Such a disabled site might have relations with other disabled sites, which this API does not reveal.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZASiteTopology
```

Retrieves a collection of Sites topology information structures for all the available user's sites.

### Example 2
```powershell
PS C:\> Get-ZASiteTopology -zOrgIdentifier "1234-5678-9012"
```

Retrieves a collection of Sites topology information structures for all the available user's sites within zOrgIdentifier "1234-5678-9012".

## PARAMETERS

### -zOrgIdentifier
The ZORG identifier by which to filter sites topology list.
If the ZORG identifier is omitted, information related to all sites topology is retrieved.

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

[Zerto Analytics REST API Endpoint for Site Topology](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_sites_format_topology)
