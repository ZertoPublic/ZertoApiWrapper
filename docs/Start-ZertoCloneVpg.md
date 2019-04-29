---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Start-ZertoCloneVpg.md
schema: 2.0.0
---

# Start-ZertoCloneVpg

## SYNOPSIS
Start a Virtual Protection Group Clone operation

## SYNTAX

```
Start-ZertoCloneVpg [-vpgName] <String> [[-checkpointIdentifier] <String>] [[-datastoreName] <String>]
 [[-vmName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Start a Virtual Protection Group Clone operation

## EXAMPLES

### Example 1
```powershell
PS C:\> Start-ZertoCloneVpg -vpgName "MyVpg"
```

Starts a clone operation of VPG "MyVpg" targeting the datastore with the most free space and the latest checkpoint.

## PARAMETERS

### -checkpointIdentifier
The identifier of the checkpoint to use for cloning.
If unspecified, the latest checkpoint will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: checkpointId

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -datastoreName
The datastore name where the clone is to be created.
If unspecified, will auto select the datastore with the most free space.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vmName
The name(s) of the VMs you wish to clone.
If unspecified, all VMs in the VPG will be cloned.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name of the VPG you wish to clone.

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
