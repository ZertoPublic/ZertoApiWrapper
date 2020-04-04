---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Invoke-ZertoEvacuateVra.md
schema: 2.0.0
---

# Invoke-ZertoEvacuateVra

## SYNOPSIS
This operation will move all VMs currently replicating to the selected host or VRA to different hosts based on internal Zerto algorithms.

## SYNTAX

### VraIdentifier (Default)
```
Invoke-ZertoEvacuateVra -VraIdentifier <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### HostName
```
Invoke-ZertoEvacuateVra -HostName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### VraName
```
Invoke-ZertoEvacuateVra -VraName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This operation will move all VMs currently replicating to the selected host or VRA to different hosts based on internal Zerto algorithms.

This will return a Zerto Task Identifier so the task progress can be tracked.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoEvacuateVra -HostName 'host01'
```

Will move all VMs currently replicating to the selected host to different hosts.

### Example 2
```powershell
PS C:\> Invoke-ZertoEvacuateVra -VraName 'Z-VRA-host01'
```

Will move all VMs currently replicating to the selected VRA to different VRAs.

### Example 3
```powershell
PS C:\> Invoke-ZertoEvacuateVra -VraIdentifier '1234-1234-4312-9856'
```

Will move all VMs currently replicating to the selected VRA to different VRAs.

## PARAMETERS

### -HostName
HostName Option

```yaml
Type: String
Parameter Sets: HostName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VraIdentifier
VRAIdentifier Option

```yaml
Type: String
Parameter Sets: VraIdentifier
Aliases: VraId, Identifier

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -VraName
VRA Option

```yaml
Type: String
Parameter Sets: VraName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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

[Zerto REST API Evacuate VRA End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.129.html%23)

