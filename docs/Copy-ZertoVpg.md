---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Copy-ZertoVpg.md
schema: 2.0.0
---

# Copy-ZertoVpg

## SYNOPSIS
Copy an existing VPG settings object to create a new VPG with the same settings. New VMs must be added to the copied VPG.

## SYNTAX

```
Copy-ZertoVpg -SourceVpgName <String> -NewVpgName <String> [-VMs] <String[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Copy an existing VPG settings object to create a new VPG with the same settings. New VMs must be added to the copied VPG.

## EXAMPLES

### Example 1
```powershell
PS C:\> Copy-ZertoVpg -SourceVpgName 'MyVpg' -NewVpgName 'MyNewVpg' -VMs 'VmToAdd01'
```

Copies the settings of 'MyVpg' into a new VPG 'MyNewVpg' adding one VM, 'VmToAdd01'

### Example 2
```powershell
PS C:\> Copy-ZertoVpg -SourceVpgName 'MyVpg' -NewVpgName 'MyNewVpg' -VMs 'VmToAdd01', 'VmToAdd02'
```

Copies the settings of 'MyVpg' into a new VPG 'MyNewVpg' adding two VMs, 'VmToAdd01' and 'VmToAdd02'

## PARAMETERS

### -NewVpgName
Name to assign the newly created VPG

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SourceVpgName
Name of the VPG to clone

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMs
Name of VMs to add to the VPG

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

[Zerto Clone VPG API Endpoint Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.119.html%23)
