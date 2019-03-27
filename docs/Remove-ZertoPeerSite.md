---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Remove-ZertoPeerSite

## SYNOPSIS

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
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
