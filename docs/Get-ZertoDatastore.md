---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertoDatastore.md
schema: 2.0.0
---

# Get-ZertoDatastore

## SYNOPSIS
Returns datastore information for the local site.

## SYNTAX

### main (Default)
```
Get-ZertoDatastore [<CommonParameters>]
```

### datastoreIdentifier
```
Get-ZertoDatastore [-datastoreIdentifier <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Returns datastore information for the local site or information for a single datastore when a datastore identifier is passed. If several datastore parameters are passed in an array, all requested datastores will be returned.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoDatastore
```

Returns all datastore information for the local site.

### Example 2
```powershell
PS C:\> Get-ZertoDatastore -datastoreIdentifier "Need to fill this in"
```

Returns all datastore information for the datastore associated with the passed identifier.

## PARAMETERS

### -datastoreIdentifier
datastoreIdentifier or array of datastoreIdentifiers to be queried

```yaml
Type: String[]
Parameter Sets: datastoreIdentifier
Aliases: datastoreId

Required: False
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

[Zerto REST API Datastore Information End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.016.html#)
