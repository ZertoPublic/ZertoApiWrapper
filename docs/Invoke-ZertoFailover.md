---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Invoke-ZertoFailover.md
schema: 2.0.0
---

# Invoke-ZertoFailover

## SYNOPSIS
Start a failover of a VPG

## SYNTAX

```
Invoke-ZertoFailover [-vpgName] <String> [[-checkpointIdentifier] <String>] [[-commitPolicy] <String>]
 [[-shutdownPolicy] <Int32>] [[-timeToWaitBeforeShutdownInSec] <Int32>] [[-reverseProtection] <Boolean>]
 [[-vmName] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Start a failover of a VPG

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoFailover -vpgName "MyVpg"
```

Start a failover of VPG "MyVpg" with the latest checkpoint and site default policies.

### Example 2
```powershell
PS C:\> Invoke-ZertoFailover -vpgName "MyVpg" -shutdownPolicy 2 -reverseProtection $false -commitPolicy 'Commit' -timeToWaitBeforeShutdownInSec 7200
```

Start a failover of VPG "MyVpg" with the latest checkpoint. VMs will attempt to be gracefully shutdown and if unsuccessful will be forcibly powered off. After 2 hours, if the VPG has not been committed or rolled back, the VPG will auto commit. Reverse protection will not be enabled.

## PARAMETERS

### -checkpointIdentifier
Checkpoint Identifier to use as the Point-In-Time to rollback to.

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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reverseProtection
True: Enable reverse protection.
The virtual machines are recovered on the recovery site and then protected using the default reverse protection settings.

False: Do not enable reverse protection.
The VPG definition is kept with the status Needs Configuration and the reverse settings in the VPG definition are not set.

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

### -shutdownPolicy
0: The protected virtual machines are not touched before starting the failover.
This assumes that you do not have access to the protected virtual machines.
-- DEFAULT

1: If the protected virtual machines have VMware Tools or Microsoft Integration Services available, the virtual machines are gracefully shut down, otherwise the failover operation fails.
This is similar to performing a Move operation to a specified checkpoint.

2: The protected virtual machines are forcibly shut down before starting the failover.
If the protected virtual machines have VMware Tools or Microsoft Integration Services available, the procedure waits five minutes for the virtual machines to be gracefully shut down before forcibly powering them off.
This is similar to performing a Move operation to a specified checkpoint.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -timeToWaitBeforeShutdownInSec
Time, in seconds, before the commitPolicy is invoked. Default setting is 3600 seconds (60 Minutes). Min value is 300 seconds (5 minutes). Max Value is 86,400 seconds (24 Hours).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vmName
Name(s) of VMs in the VPG to failover

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name of the VPG to Failover

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
