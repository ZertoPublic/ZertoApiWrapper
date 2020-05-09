---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: Invoke-ZertoMoveCommit.md
schema: 2.0.0
---

# Invoke-ZertoMoveCommit

## SYNOPSIS
Commit a VPG currently undergoing a move operation.

## SYNTAX

### Main (Default)
```
Invoke-ZertoMoveCommit -vpgName <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ReverseProtect
```
Invoke-ZertoMoveCommit -vpgName <String[]> [-reverseProtection] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### KeepSource
```
Invoke-ZertoMoveCommit -vpgName <String[]> [-keepSourceVms] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Commit a VPG currently undergoing a move operation.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoMoveCommit -vpgName "MyVpg"
```

Commit VPG "MyVpg" after a move operation has been completed. This commit process with use the `-KeepSourceVms` or `-ReverseProtection` selection made during the move initation.

### Example 2
```powershell
PS C:\> Invoke-ZertoMoveCommit -vpgName "MyVpg" -keepSourceVms
```

Commit VPG "MyVpg" after a move operation has been completed specifying to keep the vms at the source location and NOT reverse protection. This commit process will overrule any reverse protection or keep source vms selection made during the move initiation.

### Example 3
```powershell
PS C:\> Invoke-ZertoMoveCommit -vpgName "MyVpg" -reverseProtection
```

Commit VPG "MyVpg" after a move operation has been completed specifying to reverse protection of the VMs back to the source location. The VMs at the source location will be removed from inventory at the source location and the disks will be used as pre-seed volumes. This commit process will overrule any reverse protection or keep source vms selection made during the move initiation.

## PARAMETERS

### -keepSourceVms
"Use this switch to keep the source VMs at the source site. If neither 'ReverseProtction' nor 'KeepSourceVms' switch is specified, the commit process will use selection made during move initiation."

```yaml
Type: SwitchParameter
Parameter Sets: KeepSource
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reverseProtection
"Use this switch to reverse protect the VPG(s) to the source site. If neither 'ReverseProtction' nor 'KeepSourceVms' switch is specified, the commit process will use selection made during move initiation."

```yaml
Type: SwitchParameter
Parameter Sets: ReverseProtect
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name(s) of the VPG(s) to commit.

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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
