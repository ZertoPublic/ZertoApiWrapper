---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertpZsspSession.md
schema: 2.0.0
---

# Get-ZertoZsspSession

## SYNOPSIS
Retrieve a list of existing session URLs.

## SYNTAX

### default (Default)
```
Get-ZertoZsspSession [<CommonParameters>]
```

### zsspSessionIdentifier
```
Get-ZertoZsspSession [-zsspSessionIdentifier <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve a list of existing session URLs.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoZsspSession
```

Retrieve a list of existing session URLs.

## PARAMETERS

### -zsspSessionIdentifier
ZSSP Session Id(s) to get information.

```yaml
Type: String[]
Parameter Sets: zsspSessionIdentifier
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Zerto REST API ZSSP Session End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.132.html#)
