---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/Master/docs/Import-ZertoVpg.md
schema: 2.0.0
---

# Import-ZertoVpg

## SYNOPSIS
Reads in one or more JSON files and imports each one into a VPG.

## SYNTAX

```
Import-ZertoVpg [-settingsFile] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Reads in one or several JSON files and imports each one into a VPG. Currently this method does not support using pre-seed volumes. We are working through a method to get this working, but it may be a while until this happens.

## EXAMPLES

### Example 1
```powershell
PS C:> Import-ZertoVpg -settingsFile "C:\ZertoVpgs\My Vpg.json"
```

Reads in "My Vpg.json", creates a new VPG object, applies all the settings and saves the VPG.

## PARAMETERS

### -settingsFile
VPG settings JSON file(s) to import.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: FullName

Required: True
Position: 0
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

[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)
