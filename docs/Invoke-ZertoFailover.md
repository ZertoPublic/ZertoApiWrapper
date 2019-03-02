---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Invoke-ZertoFailover

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

```
Invoke-ZertoFailover [-vpgName] <String> [[-checkpointIdentifier] <String>] [[-commitPolicy] <String>]
 [[-commitValue] <String>] [[-shutdownPolicy] <Int32>] [[-timeToWaitBeforeShutdownInSec] <Int64>]
 [[-reverseProtection] <Boolean>] [[-vmName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -checkpointIdentifier
Checkpoint Identifier to use as the Point-In-Time to rollback to.

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

### -commitPolicy
0: After the seconds specified in the commitValue setting have elapsed, the failover is rolled back.
            1: After the seconds specified in the commitValue setting have elapsed, the failover continues, committing the virtual machines in the recovery site.
            2: The virtual machines in the VPG being failed over remain in the Before Commit state until either they are committed with Commit a failover, or rolled back with Roll back a failover.
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

### -commitValue
The amount of time in seconds the failover waits in a Before Commit state to enable checking that the failover is as required before performing the commitPolicy setting.
Default is the Site Setting

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Time, in seconds, before VMs are forcibly turned off if the Force Shutdown option is seclected after attempting to gracefully shut down the VMs

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vmName
Name(s) of VMs in the

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
