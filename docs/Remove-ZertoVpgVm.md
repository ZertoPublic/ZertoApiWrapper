---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Resume-ZertoVpgVm.md
schema: 2.0.0
---

# Remove-ZertoVpgVm

## SYNOPSIS
Removes one or more VMs from a specified VPG. A Task Identifier is returned to track progress.

## SYNTAX

```
Remove-ZertoVpgVm -VpgName <String> -Vm <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes one or more VMs from a specified VPG. A Task Identifier is returned to track progress. Internal logic will remove duplicate VM names from the list of VMs provided as well as ensure membership in the VPG specified prior to attempting to remove the VM from the VPG. Finally the VPG is saved to commit the changes. ChangeImpact is set to 'High' to get the confirmation prompt.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-ZertoVpgVm -VpgName 'My Vpg' -Vm 'Vm 1'
```

Removes 'Vm 1' from Vpg named 'My Vpg'

### Example 2
```powershell
PS C:\> Remove-ZertoVpgVm -VpgName 'My Vpg' -Vm 'Vm 1', 'Vm 2'
```

Removes 'Vm 1' and 'Vm 2' from Vpg named 'My Vpg'.

### Example 3
```powershell
PS C:\> Remove-ZertoVpgVm -VpgName 'My Vpg' -Vm 'Vm 1', 'Vm 2' -Confirm:$False
```

Removes 'Vm 1' and 'Vm 2' from Vpg named 'My Vpg' and bypasses the confirmation prompt

## PARAMETERS

### -Vm
Name of VM(s) to remove from the VPG

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VpgName
Name of the VPG that contains the VM you wish to remove

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

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Remove Vms from a VPG Settings Object](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20(ZVM)%20-%20vSphere%20Online%20Help/content/zvr_apis/vpg_management_api.htm?tocpath=ZVR%20RESTful%20APIs%7CZerto%20APIs%7C_____20#statusapis_4057192544_1361409)
