---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoPeerSite

## SYNOPSIS
{{Fill in the Synopsis}}

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
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Zerto REST API Peer Site End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.038.html#)
