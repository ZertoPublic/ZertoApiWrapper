---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Remove-ZertoPeerSite.md
schema: 2.0.0
---

# Remove-ZertoPeerSite

## SYNOPSIS

Unpair the current site from another site paired to it.

## SYNTAX

### siteIdentifier (Default)
```
Remove-ZertoPeerSite -siteIdentifier <String[]> [-keepTargetDisks] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### peerSiteName
```
Remove-ZertoPeerSite -peerSiteName <String[]> [-keepTargetDisks] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### hostName
```
Remove-ZertoPeerSite -hostName <String[]> [-keepTargetDisks] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Unpair the current site from another site paired to it.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-ZertoPeerSite -siteIdentifier "MySiteIdentifier"
```

Unpairs the current site for the site with siteIdentifier "MySiteIdentifier"

### Example 2
```powershell
PS C:\> Remove-ZertoPeerSite -peerSiteName "Recovery Site"
```

Unpairs the current site for the site with site name "Recovery Site"

### Example 1
```powershell
PS C:\> Remove-ZertoPeerSite -hostName "192.168.1.100"
```

Unpairs the current site for the site with ip address "192.168.1.100"

## PARAMETERS

### -hostName
IP address of the peer site to be removed from the connected site

```yaml
Type: String[]
Parameter Sets: hostName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -keepTargetDisks
Specify this switch to Keep the target replica disks for any VPGs replicating between the sites as the VPGs will be deleted by unpairing the sites.
If this switch is not used, the target replica disks will be deleted

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -peerSiteName
Name of the peer site to be removed from the connected site

```yaml
Type: String[]
Parameter Sets: peerSiteName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -siteIdentifier
Identifier of the site to be removed from the connected site

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto REST API Peer Site End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.044.html%23)