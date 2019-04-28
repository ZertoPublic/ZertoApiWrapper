---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertoLocalSite.md
schema: 2.0.0
---

# Get-ZertoLocalSite

## SYNOPSIS
Returns information about the local site.

## SYNTAX

```
Get-ZertoLocalSite [-pairingstatuses] [<CommonParameters>]
```

## DESCRIPTION
Returns information about the local site. Please see the Zerto API Documentation for specifics on the information returned.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoLocalSite
```

Returns information about the local site.

## PARAMETERS

### -pairingstatuses
Switch to return possible paiting statuses.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Local Site End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.038.html#)
