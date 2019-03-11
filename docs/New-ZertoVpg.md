---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/New-ZertoVpg.md
schema: 2.0.0
---

# New-ZertoVpg

## SYNOPSIS
Creates a New VPG with default settings only. Customization of VM settings can be accomplished with other module level functions.

## SYNTAX

### recoveryClusterDatastoreCluster
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryCluster <String> -datastoreCluster <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [<CommonParameters>]
```

### recoveryClusterDatastore
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryCluster <String> -datastore <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [<CommonParameters>]
```

### recoveryHostDatastoreCluster
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryHost <String> -datastoreCluster <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [<CommonParameters>]
```

### recoveryHostDatastore
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryHost <String> -datastore <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [<CommonParameters>]
```

### recoveryResourcePoolDatastoreCluster
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryResourcePool <String> -datastoreCluster <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [<CommonParameters>]
```

### recoveryResourcePoolDatastore
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryResourcePool <String> -datastore <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -datastore
Name of the datastore where the VM(s), Volume(s), and Journal(s) will reside.

```yaml
Type: String
Parameter Sets: recoveryClusterDatastore, recoveryHostDatastore, recoveryResourcePoolDatastore
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -datastoreCluster
Name of the datastore cluster where the VM(s), Volume(s), and Journal(s) will reside.

```yaml
Type: String
Parameter Sets: recoveryClusterDatastoreCluster, recoveryHostDatastoreCluster, recoveryResourcePoolDatastoreCluster
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -journalHistoryInHours
Journal History in Hours.
Min 1 hour, Max 720 Hours (30 days)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -protectedVm
Name(s) of the VM(s) to be protected.

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

### -recoveryCluster
Name of the cluster where the VM(s) will be recovered.

```yaml
Type: String
Parameter Sets: recoveryClusterDatastoreCluster, recoveryClusterDatastore
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoveryFolder
Name of folder at recovery location where the recovered virtual machine(s) will be created.

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

### -recoveryHost
Name of the host where the VM(s) will be recovered.

```yaml
Type: String
Parameter Sets: recoveryHostDatastoreCluster, recoveryHostDatastore
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoveryNetwork
Name of the network to use during a Failover Live \ Move VPG operation.

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

### -recoveryResourcePool
Name of the resource pool where the VM(s) will be recovered.

```yaml
Type: String
Parameter Sets: recoveryResourcePoolDatastoreCluster, recoveryResourcePoolDatastore
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoverySite
Name of the site where the VM(s) will be recoveryed

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

### -rpoInSeconds
RPO alert

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceProfile
Service profile name to use.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -testIntervalInMinutes
Minimum test interval for this VPG.
Minimum test interval for this VPG. Valid values are 0: Off, 43200: 1 Month, 131040: 3 Months, 262080: 6 Months, 294560: 9 Months, 252600: 12 Months

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 0, 43200, 131040, 262080, 294560, 252600

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -testNetwork
Name of the network to use during a Failover Test operation

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

### -useWanCompression
Turn on or off WAN and Journal Compression.
Default is turned on.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name of the VPG

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

### -vpgPriority
VPG Priority.
High, Medium, or Low.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: High, Medium, Low

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zorg
Name of ZORG to use.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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

### System.String
## NOTES

## RELATED LINKS
[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)