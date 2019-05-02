---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertoVolume.md
schema: 2.0.0
---

# Get-ZertoVolume

## SYNOPSIS
Returns information about all volumes in the site processing the API.

## SYNTAX

### main (Default)
```
Get-ZertoVolume [<CommonParameters>]
```

### filter
```
Get-ZertoVolume [-volumeType <String>] [-vpgIdentifier <String>] [-datastoreIdentifier <String>]
 [-protectedVmIdentifier <String>] [-owningVmIdentifier <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns information about all volumes in the site processing the API.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoVolume
```

Returns information about all volumes in the site processing the API.

### Example 2
```powershell
PS C:\> Get-ZertoVolume -vpgIdentifier "MyVpgIdentifier"
```

Returns information about all volumes associated with vpgIdentifier "MyVpgIdentifier" in the site processing the API.

### Example 3
```powershell
PS C:\> Get-ZertoVolume
```

Returns information about all volumes in the site processing the API.

## PARAMETERS

### -datastoreIdentifier
The identifier of the datastore.

```yaml
Type: String
Parameter Sets: filter
Aliases: datastoreId, dsId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -owningVmIdentifier
The identifier of the owning virtual machine.

```yaml
Type: String
Parameter Sets: filter
Aliases: owningVmId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -protectedVmIdentifier
The identifier of the protected virtual machine.

```yaml
Type: String
Parameter Sets: filter
Aliases: protectedVmId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -volumeType
The type of volume.
Please see Zerto API Documentation for possible values.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgIdentifier
The identifier of the VPG.

```yaml
Type: String
Parameter Sets: filter
Aliases: vpgId

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

[Zerto REST API Volumes End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.094.html#)
