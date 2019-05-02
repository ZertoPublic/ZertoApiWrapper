---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertoPeerSite.md
schema: 2.0.0
---

# Get-ZertoPeerSite

## SYNOPSIS
Returns information about the peer sites.

## SYNTAX

### main (Default)
```
Get-ZertoPeerSite [<CommonParameters>]
```

### pairingStatuses
```
Get-ZertoPeerSite [-pairingStatuses] [<CommonParameters>]
```

### siteIdentifier
```
Get-ZertoPeerSite -siteIdentifier <String[]> [<CommonParameters>]
```

### filter
```
Get-ZertoPeerSite [-peerName <String>] [-paringStatus <String>] [-location <String>] [-hostName <String>]
 [-port <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns information about a peer site. When called without any parameters, will return basic information about all peer sites.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoPeerSite
```

Returns basic information about all sites connected to this site.

### Example 1
```powershell
PS C:\> Get-ZertoPeerSite -siteIdentifier "MySiteIdentifier"
```

Returns basic information about site with site identifier "MySiteIdentifier"

## PARAMETERS

### -hostName
The IP address of a Zerto Virtual Manager, paired with this site, for which information is to be returned.

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

### -location
The site location, as specified in the site information, for which information is to be returned.

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

### -pairingStatuses
Switch to return possible paiting statuses.

```yaml
Type: SwitchParameter
Parameter Sets: pairingStatuses
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -paringStatus
The pairing status for which information is to be returned.

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

### -peerName
The name of a peer site for which information is to be returned.
The name is case-sensitive.

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

### -port
The port used to access peer sites for which information is to be returned.
The default port is 9081.

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

### -siteIdentifier
The identifier(s) of the peer site(s) for which information is to be returned.

```yaml
Type: String[]
Parameter Sets: siteIdentifier
Aliases: siteId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Peer Site End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.038.html#)
