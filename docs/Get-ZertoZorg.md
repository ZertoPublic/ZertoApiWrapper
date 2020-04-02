---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoZorg.md
schema: 2.0.0
---

# Get-ZertoZorg

## SYNOPSIS
Returns information about Zerto organizations, ZORGs, defined in the Zerto Cloud Manager that is connected to the site where the API runs

## SYNTAX

### default (Default)
```
Get-ZertoZorg [<CommonParameters>]
```

### zorgIdentifier
```
Get-ZertoZorg [-zorgIdentifier <String[]>] [<CommonParameters>]
```

## DESCRIPTION
returns information about Zerto organizations, ZORGs, defined in the Zerto Cloud Manager that is connected to the site where the API runs

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoZorg
```

returns information about Zerto organizations, ZORGs, defined in the Zerto Cloud Manager that is connected to the site where the API runs

### Example 2
```powershell
PS C:\> Get-ZertoZorg -zorgIdentifier "myZorgIdentifier"
```

returns information about Zerto Organization with identifier "MyZorgIdentifier"

## PARAMETERS

### -zorgIdentifier
Identifier(s) of the ZORG.

```yaml
Type: String[]
Parameter Sets: zorgIdentifier
Aliases: zorgId

Required: False
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

[Zerto REST API ZOrg End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.126.html#)
