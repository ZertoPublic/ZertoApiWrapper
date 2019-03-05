---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoServiceProfile

## SYNOPSIS
Returns information about service profiles that are defined in the Zerto Cloud Manager that is connected to the site where the API runs.

## SYNTAX

### main (Default)
```
Get-ZertoServiceProfile [<CommonParameters>]
```

### siteIdentifier
```
Get-ZertoServiceProfile [-siteIdentifier <String>] [<CommonParameters>]
```

### serviceProfileId
```
Get-ZertoServiceProfile [-serviceProfileId <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Returns information about service profiles that are defined in the Zerto Cloud Manager that is connected to the site where the API runs.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoServiceProfile
```

Returns service profile defined in the Zerto Cloud Manager connected to this site.

## PARAMETERS

### -serviceProfileId
The service profile ID for which information should be returned.

```yaml
Type: String[]
Parameter Sets: serviceProfileId
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteIdentifier
The identifier of the site for which service profiles should be returned.

```yaml
Type: String
Parameter Sets: siteIdentifier
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
[Zerto REST API Service Profile End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.062.html#)
