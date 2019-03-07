---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Invoke-ZertoMove.md
schema: 2.0.0
---

# Invoke-ZertoMove

## SYNOPSIS
Start a move of a VPG.

## SYNTAX

```
Invoke-ZertoMove [-vpgName] <String[]> [[-commitPolicy] <String>] [[-commitPolicyTimeout] <Int32>]
 [[-forceShutdown] <Boolean>] [[-reverseProtection] <Boolean>] [[-keepSourceVms] <Boolean>]
 [[-continueOnPreScriptFailure] <Boolean>] [<CommonParameters>]
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
The policy to use after the move enters a 'Before Commit' state.
If omitted, the site settings default will be applied.
Valid values are: '0' or 'Rollback', '1' or 'Commit', '2' or 'None'.
Please see Zerto API Documentation for additional information.

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

### -continueOnPreScriptFailure
False: Do not continue the Move operation in case of failure of script executing prior the operation.

True: Continue the Move operation in case of failure of script executing prior the operation.

Default: False

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -forceShutdown
False: If a utility (VMware Tools) is installed on the protected virtual machines, the procedure waits five minutes for the virtual machines to be gracefully shut down before forcibly powering them off.

True: To force a shutdown of the virtual machines.

Default: True

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -keepSourceVms
False: Remove the protected virtual machines from the protected site.

True: Prevent the protected virtual machines from being deleted in the protected site.

Default: False

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reverseProtection
False: Do not enable reverse protection.
The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set.

True: Enable reverse protection.
The virtual machines are recovered on the recovery site and then protected using the default reverse protection settings.

Default Value: True

Note: If ReverseProtection is set to True, the KeepSourceVMs should be ignored because the virtual disks of the VMs are used for replication and cannot have VMs attached.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
