---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Remove-ZertoVpg.md
schema: 2.0.0
---

# Remove-ZertoVpg

## SYNOPSIS
Deletes a Zerto Virtual Protection Group

## SYNTAX

```
Remove-ZertoVpg [-vpgName] <String> [-keepRecoveryVolumes] [-force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a Zerto Virtual Protection Group.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-ZertoVpg -vpgName "MyVpg"
```

Deletes Zerto Virtual Protection Group named "MyVpg". Recovery volumes at the recovery site will be deleted.

### Example 2
```powershell
PS C:\> Remove-ZertoVpg -vpgName "MyVpg" -keepRecoveryVolumes
```

Deletes Zerto Virtual Protection Group named "MyVpg". Recovery volumes at the recovery site will be retained.

## PARAMETERS

### -force
Use this switch to force delete the VPG.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -keepRecoveryVolumes
Use this switch to keep the recovery volumes at the target site.
If the virtual machines in the deleted VPG are reprotected, these volumes can be used as preseeded volumes to speed up the initial synchronization of the new VPG.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name of the VPG to delete.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
