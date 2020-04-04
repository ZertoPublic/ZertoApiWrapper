---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZATask.md
schema: 2.0.0
---

# Get-ZADatastore

## SYNOPSIS

Get a list of datastore/s, filtered by site. Enter a site identifier only to get the list of all datastores. Enter a site identifier and cluster identifier to get a list of datastores in the cluster. Enter a site identifier and datastore identifier to get specific datastore info.

## SYNTAX

### AllInfo (Default)
```
Get-ZADatastore -siteIdentifier <String> [<CommonParameters>]
```

### datastore
```
Get-ZADatastore -siteIdentifier <String> -datastoreIdentifier <String> [<CommonParameters>]
```

### cluster
```
Get-ZADatastore -siteIdentifier <String> -clusterIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION

Get a list of datastore/s, filtered by site. Enter a site identifier only to get the list of all datastores. Enter a site identifier and cluster identifier to get a list of datastores in the cluster. Enter a site identifier and datastore identifier to get specific datastore info.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZADatastore -siteIdentifier "7890-1234-5678"
```

Returns all datastore clusters and datastores associated with site identifier "7890-1234-5678"

### Example 2
```powershell
PS C:\> Get-ZADatastore -siteIdentifier "7890-1234-5678" -clusterIdentifier "3456-7890-1234"
```

Returns datastore cluster information with identifier "3456-7890-1234" associated with site identifier "7890-1234-5678"

### Example 3
```powershell
PS C:\> Get-ZADatastore -siteIdentifier "7890-1234-5678" -datastoreIdentifier "5678-9012-3456"
```

Returns all datastore information with identifier "5678-9012-3456" associated with site identifier "7890-1234-5678"

## PARAMETERS

### -clusterIdentifier
The datastore cluster identifier.
Gets a list of datastores in the cluster.

```yaml
Type: String
Parameter Sets: cluster
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -datastoreIdentifier
The datastore identifer.
Gets the datastore info.

```yaml
Type: String
Parameter Sets: datastore
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifier
The site identifier.
The site identifier is mandatory.
Omit the datastore and datastore cluster identifiers to view site level storage information.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Datastores](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_datastores)
