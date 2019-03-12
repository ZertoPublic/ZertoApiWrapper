---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Uninstall-ZertoVra.md
schema: 2.0.0
---

# Uninstall-ZertoVra

## SYNOPSIS
Uninstalls a Zerto Virtual Replication Appliance from a target host

## SYNTAX

```
Uninstall-ZertoVra [-hostName] <String[]> [<CommonParameters>]
```

## DESCRIPTION
Uninstalls a Zerto Virtual Replication Appliance from a target host

## EXAMPLES

### Example 1
```powershell
PS C:\> Uninstall-ZertoVra -hostName "Host01"
```

Uninstalls a Zerto Virtual Replication Appliance from host "Host01"

## PARAMETERS

### -hostName
Host Name attached to the VRA to be removed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Zerto REST API VRA End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.117.html#)
