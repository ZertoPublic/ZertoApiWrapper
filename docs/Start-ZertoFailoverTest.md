---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Start-ZertoFailoverTest.md
schema: 2.0.0
---

# Start-ZertoFailoverTest

## SYNOPSIS
Start a Test Failover of a specific Virtual Protection Group

## SYNTAX

```
Start-ZertoFailoverTest [-vpgName] <String> [[-checkpointIdentifier] <String>] [[-vmName] <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION
Start a Test Failover of a specific Virtual Protection Group

## EXAMPLES

### Example 1
```powershell
PS C:\> Start-ZertoFailoverTest -vpgName "MyVpg"
```

Starts a Failover test of a Virtual Protection Group "MyVpg" at the latest checkpoint with all virtual machines.

## PARAMETERS

### -checkpointIdentifier
The identifier of the checkpoint to use for testing.
If unspecified, the latest checkpoint will be used.

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

### -vmName
The name(s) of the VMs within the selected VPG you wish to test.
If unspecified, all VMs in the VPG will be tested.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name of VPG to failover test

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
[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
