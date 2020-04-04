---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Export-ZertoVpg.md
schema: 2.0.0
---

# Export-ZertoVpg

## SYNOPSIS
Exports a VPG Settings Object to a JSON file. This file can be used to re-import the VPG at a later time.

## SYNTAX

### namedVpgs
```
Export-ZertoVpg -outputPath <String> -vpgName <String[]> [<CommonParameters>]
```

### allVpgs
```
Export-ZertoVpg -outputPath <String> [-allVpgs] [<CommonParameters>]
```

## DESCRIPTION
Exports a VPG Settings Object to a JSON file. This file can be used to re-import the VPG at a later time.

## EXAMPLES

### Example 1
```powershell
PS C:> Export-ZertoVpg -outputPath "C:\ZertoVPGs" -vpgName "My Vpg", "My Other Vpg"
```

Exports VPG settings for VPGs "My Vpg" and "My Other Vpg". Each settings object will be placed inside a JSON file at C:\ZertoVPGs\ with the name of the file being the name of the VPG.

### Example 2
```powershell
PS C:> Export-ZertoVpg -outputPath "C:\ZertoVPGs" -allVpgs
```

Exports VPG settings for all Vpgs replicated to or from this site. Each settings object will be placed inside a JSON file at C:\ZertoVPGs\ with the name of the file being the name of the VPG. If a VPG is in an un-editable state, it cannot be exported.

## PARAMETERS

### -allVpgs
Export all VPGs at this site

```yaml
Type: SwitchParameter
Parameter Sets: allVpgs
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -outputPath
Location where to dump the resulting JSON files containing the VPG Settings

```yaml
Type: String
Parameter Sets: (All)
Aliases: outputFolder

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name(s) of the VPG(s) to be exported

```yaml
Type: String[]
Parameter Sets: namedVpgs
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

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)
