---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Invoke-ZertoMove.md
schema: 2.0.0
---

# Invoke-ZertoMove

## SYNOPSIS
Start a move of a VPG.

## SYNTAX

### main (Default)
```
Invoke-ZertoMove [-vpgName] <String[]> [[-commitPolicy] <String>] [[-commitPolicyTimeout] <Int32>]
 [-forceShutdown] [-ContinueOnPreScriptFailure] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### disableReverseProtection
```
Invoke-ZertoMove [-vpgName] <String[]> [[-commitPolicy] <String>] [[-commitPolicyTimeout] <Int32>]
 [-forceShutdown] [-disableReverseProtection] [-ContinueOnPreScriptFailure] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### keepSourceVms
```
Invoke-ZertoMove [-vpgName] <String[]> [[-commitPolicy] <String>] [[-commitPolicyTimeout] <Int32>]
 [-forceShutdown] [-keepSourceVms] [-ContinueOnPreScriptFailure] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Start a move of a VPG.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoMove -vpgName "MyVpg"
```

Starts a move operation of VPG "MyVpg"

## PARAMETERS

### -commitPolicy
'Rollback': After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.

'Commit': After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.

'None': The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.

Default is the Site Settings setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -commitPolicyTimeout
The amount of time, in seconds, the Move is in a 'Before Commit' state, before performing the commitPolicy setting.
If omitted, the site settings default will be applied.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContinueOnPreScriptFailure
Use this switch to continue the Move operation even if the Pre-Script fails to run properly.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableReverseProtection
Do not enable reverse protection. The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set.

```yaml
Type: SwitchParameter
Parameter Sets: disableReverseProtection
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -forceShutdown
By default all virtual machines will attempt to be gracefully shutdown. If a source VM is not running VMware tools or cannot be gracefully shutdown, use this switch to force shutdown the source VMs.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -keepSourceVms
Use this switch to Prevent the protected virtual machines from being deleted in the protected site. Reverse protection is not automatic with this selection and should reverse protection be required, must be manually configured post commit.

```yaml
Type: SwitchParameter
Parameter Sets: keepSourceVms
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name(s) of the VPG(s) you want to move.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
