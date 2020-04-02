---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAVolume.md
schema: 2.0.0
---

# Get-ZAVolume

## SYNOPSIS

Retrieves account volumes by datastore. Enter a site identifier and cluster identifier to get the list of volumes that exist in the datastore cluster. Or, enter a site identifier and datastore identifier to get the list of volumes that exist in the datastore. To retrieve all volumes for a specific VPG, enter a VPG identifier only.

## SYNTAX

### VpgIdentifier (Default)
```
Get-ZAVolume -vpgIdentifier <String> [<CommonParameters>]
```

### SiteAndDatastoreIdentifier
```
Get-ZAVolume -siteIdentifier <String> -datastoreIdentifier <String> [<CommonParameters>]
```

### SiteAndClusterIdentifier
```
Get-ZAVolume -siteIdentifier <String> -clusterIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION

Retrieves account volumes by datastore. Enter a site identifier and cluster identifier to get the list of volumes that exist in the datastore cluster. Or, enter a site identifier and datastore identifier to get the list of volumes that exist in the datastore. To retrieve all volumes for a specific VPG, enter a VPG identifier only.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAVolume -vpgIdentifier "2345-6789-0123"
```

Returns all volume information for all VMs in VPG with Identifier "2345-6789-0123"

### Example 2
```powershell
PS C:\> Get-ZAVolume -siteIdentifier "3456-7890-1234" -clusterIdentifier "0123-4567-8901"
```

Returns all volume information for all volumes in Site with Identifier "3456-7890-1234" on Datastore Cluster with Identifier "0123-4567-8901"

### Example 3
```powershell
PS C:\> Get-ZAVolume -siteIdentifier "3456-7890-1234" -datastoreIdentifier "5678-9012-3456"
```

Returns all volume information for all volumes in Site with Identifier "3456-7890-1234" on Datastore with Identifier "5678-9012-3456"

## PARAMETERS

### -clusterIdentifier
The cluster identifier.
If a cluster identifier is not entered, you must enter a datastore identifier.

```yaml
Type: String
Parameter Sets: SiteAndClusterIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -datastoreIdentifier
The datastore identifer.
If a datastore identifier is not entered, you must enter a cluster identifier.

```yaml
Type: String
Parameter Sets: SiteAndDatastoreIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifier
The site identifier.
The site identifier is mandatory if vpgIdentifier is not entered.

```yaml
Type: String
Parameter Sets: SiteAndDatastoreIdentifier, SiteAndClusterIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgIdentifier
The vpg identifer.

```yaml
Type: String
Parameter Sets: VpgIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Volumes](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_volumes)
