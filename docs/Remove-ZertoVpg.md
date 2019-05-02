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

### vpgIdentifier (Default)
```
Remove-ZertoVpg -vpgidentifier <String[]> [-keepRecoveryVolumes] [-force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### vpgName
```
Remove-ZertoVpg [-vpgName] <String[]> [-keepRecoveryVolumes] [-force] [-WhatIf] [-Confirm] [<CommonParameters>]
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
PS C:\> Remove-ZertoVpg -vpgName "MyVpg", "MyOtherVpg" -keepRecoveryVolumes
```

Deletes Zerto Virtual Protection Groups named "MyVpg" and "MyOtherVpg." Recovery volumes at the recovery site will be retained for both VPGs.

### Example 3

```powershell
PS C:\> Remove-ZertoVpg -vpgIdentifier "MyVpgIdentifier" -keepRecoveryVolumes
```

Deletes Zerto Virtual Protection Group with vpgIdentifier "MyVpgIdentifier". Recovery volumes at the recovery site will be retained.

### Example 4

```powershell
PS C:\> Get-ZertoVpg -recoverySiteIdentifier "MyRecoverySiteIdentifier" | Remove-ZertoVpg
```

Uses the `Get-ZertoVpg` function to get all VPGs currently being protected to recovery site with identifier "MyRecoverySiteIdentifier." This information is piped into the `Remove-ZertoVpg` function and will remove all VPGs being protected to the specified recovery site.

## PARAMETERS

### -force

Use this switch to force delete the VPG. If unused, a non-forced remove vpg operation will be executed.

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

### -keepRecoveryVolumes

Use this switch to keep the recovery volumes at the target site.  If the virtual machines in the deleted VPG are re-protected, these volumes can be used as pre-seed volumes to speed up the initial synchronization of the new VPG. If this switch is not set, recovery volumes will not be retained. If required to be retained, get the path to these volumes prior to the deletion to use as pre-seed volumes for an easier operation.

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

### -vpgidentifier

vpgIdentifier(s) of the VPG(s) to delete.

```yaml
Type: String[]
Parameter Sets: vpgIdentifier
Aliases: vpgId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -vpgName

Name(s) of the VPG(s) to delete.

```yaml
Type: String[]
Parameter Sets: vpgName
Aliases:

Required: True
Position: 0
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

### None

## OUTPUTS

### System.Object

Task Identifier of the Remove operation

## NOTES

## RELATED LINKS

[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
