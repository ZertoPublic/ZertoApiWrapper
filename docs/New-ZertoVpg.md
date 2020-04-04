---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/New-ZertoVpg.md
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
 [-journalDatastore <String>] [-journalHardLimitInMb <UInt64>] [-journalWarningThresholdInMb <UInt64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### recoveryClusterDatastore
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryCluster <String> -datastore <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [-journalDatastore <String>] [-journalHardLimitInMb <UInt64>] [-journalWarningThresholdInMb <UInt64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### recoveryHostDatastoreCluster
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryHost <String> -datastoreCluster <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [-journalDatastore <String>] [-journalHardLimitInMb <UInt64>] [-journalWarningThresholdInMb <UInt64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### recoveryHostDatastore
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryHost <String> -datastore <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [-journalDatastore <String>] [-journalHardLimitInMb <UInt64>] [-journalWarningThresholdInMb <UInt64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### recoveryResourcePoolDatastoreCluster
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryResourcePool <String> -datastoreCluster <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [-journalDatastore <String>] [-journalHardLimitInMb <UInt64>] [-journalWarningThresholdInMb <UInt64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### recoveryResourcePoolDatastore
```
New-ZertoVpg -vpgName <String> [-vpgPriority <String>] [-journalHistoryInHours <Int32>] -protectedVm <String[]>
 -recoverySite <String> -recoveryResourcePool <String> -datastore <String> -recoveryFolder <String>
 [-rpoInSeconds <Int32>] [-testIntervalInMinutes <Int32>] [-serviceProfile <String>]
 [-useWanCompression <Boolean>] [-zorg <String>] -recoveryNetwork <String> -testNetwork <String>
 [-journalDatastore <String>] [-journalHardLimitInMb <UInt64>] [-journalWarningThresholdInMb <UInt64>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a New VPG with minimal default settings only. If additional configuration is desired, the VPG settings identifier will be returned and can be passed to other VPG modifying functions to include additional details.

Finally, to save the settings, you need to pass the Vpg Settings Identifier to the `Save-ZertoVpgSettings` function to commit the the VPG.

## EXAMPLES

### Example 1
```powershell
PS C:> New-ZertoVpg -vpgName "MyVpg" -protectedVm "WebServer01", "AppServer01", "DatabaseServer01" -recoverySite "Recovery Site" -recoveryFolder "Recovered VMs" -recoveryCluster "Recovery Cluster Name" -recoveryDatastoreCluster "Datastore Cluster Name" -testNetwork "Test Bubble Network" -recoveryNetwork "VM Network"
```

Creates a VPG Settings Object for a VPG called "MyVpg" and protecting Virtual Machines "WebServer01", "AppServer01", and "DatabaseServer01" targeting site "Recovery Site." The Virtual machines will be placed on the compute cluster "Recovery Cluster Name" on the datastore cluster "Datastore Cluster Name." When the virtual machines are created at the recovery site, they will be created in the folder "Recovered VMs." Finally, the network to be used during a live event will be "VM Network" and during a test operation will be "VM Network." Other values set will be the defaults, such as:

- VpgPriority: Medium
- JournalHistoryInHours: 24
- RpoInSeconds: 300
- TestIntervalInMinutes: 262080
- UseWanCompression: True
- ServiceProfile: Null
- Zorg: Null

### Example 2
```powershell
PS C:> New-ZertoVpg -vpgName "MyVpg" -protectedVm "WebServer01", "AppServer01", "DatabaseServer01" -recoverySite "Recovery Site" -recoveryFolder "Recovered VMs" -recoveryCluster "Recovery Cluster Name" -recoveryDatastore "Datastore Name" -testNetwork "Test Bubble Network" -recoveryNetwork "VM Network"
```

Creates a VPG Settings Object for a VPG called "MyVpg" and protecting Virtual Machines "WebServer01", "AppServer01", and "DatabaseServer01" targeting site "Recovery Site." The Virtual machines will be placed on the compute cluster "Recovery Cluster Name" on the datastore named "Datastore Name." When the virtual machines are created at the recovery site, they will be created in the folder "Recovered VMs." Finally, the network to be used during a live event will be "VM Network" and during a test operation will be "VM Network." Other values set will be the defaults, such as:

- VpgPriority: Medium
- JournalHistoryInHours: 24
- RpoInSeconds: 300
- TestIntervalInMinutes: 262080
- UseWanCompression: True
- ServiceProfile: Null
- Zorg: Null

### Example 3
```powershell
PS C:> New-ZertoVpg -vpgName "MyVpg" -protectedVm "WebServer01", "AppServer01", "DatabaseServer01" -recoverySite "Recovery Site" -recoveryFolder "Recovered VMs" -recoveryHost "Recovery Host Name" -recoveryDatastore "Datastore Name" -testNetwork "Test Bubble Network" -recoveryNetwork "VM Network"
```

Creates a VPG Settings Object for a VPG called "MyVpg" and protecting Virtual Machines "WebServer01", "AppServer01", and "DatabaseServer01" targeting site "Recovery Site." The Virtual machines will be placed on the compute host "Recovery Cluster Name" on the datastore named "Datastore Name." When the virtual machines are created at the recovery site, they will be created in the folder "Recovered VMs." Finally, the network to be used during a live event will be "VM Network" and during a test operation will be "VM Network." Other values set will be the defaults, such as:

- VpgPriority: Medium
- JournalHistoryInHours: 24
- RpoInSeconds: 300
- TestIntervalInMinutes: 262080
- UseWanCompression: True
- ServiceProfile: Null
- Zorg: Null

### Example 4
```powershell
PS C:> New-ZertoVpg -vpgName "MyVpg" -protectedVm "WebServer01", "AppServer01", "DatabaseServer01" -recoverySite "Recovery Site" -recoveryFolder "Recovered VMs" -recoveryHost "Recovery Host Name" -recoveryClusterDatastore "Datastore Cluster Name" -testNetwork "Test Bubble Network" -recoveryNetwork "VM Network"
```

Creates a VPG Settings Object for a VPG called "MyVpg" and protecting Virtual Machines "WebServer01", "AppServer01", and "DatabaseServer01" targeting site "Recovery Site." The Virtual machines will be placed on the compute host "Recovery Name" on the datastore named "Datastore Cluster Name." When the virtual machines are created at the recovery site, they will be created in the folder "Recovered VMs." Finally, the network to be used during a live event will be "VM Network" and during a test operation will be "VM Network." Other values set will be the defaults, such as:

- VpgPriority: Medium
- JournalHistoryInHours: 24
- RpoInSeconds: 300
- TestIntervalInMinutes: 262080
- UseWanCompression: True
- ServiceProfile: Null
- Zorg: Null

### Example 5
```powershell
PS C:> New-ZertoVpg -vpgName "MyVpg" -protectedVm "WebServer01", "AppServer01", "DatabaseServer01" -recoverySite "Recovery Site" -recoveryFolder "Recovered VMs" -recoveryResourcePool "Recovery Resource Pool Name" -recoveryDatastore "Datastore Name" -testNetwork "Test Bubble Network" -recoveryNetwork "VM Network"
```

Creates a VPG Settings Object for a VPG called "MyVpg" and protecting Virtual Machines "WebServer01", "AppServer01", and "DatabaseServer01" targeting site "Recovery Site." The Virtual machines will be placed on the resource pool "Recovery Resource Pool Name" on the datastore named "Datastore Name." When the virtual machines are created at the recovery site, they will be created in the folder "Recovered VMs." Finally, the network to be used during a live event will be "VM Network" and during a test operation will be "VM Network." Other values set will be the defaults, such as:

- VpgPriority: Medium
- JournalHistoryInHours: 24
- RpoInSeconds: 300
- TestIntervalInMinutes: 262080
- UseWanCompression: True
- ServiceProfile: Null
- Zorg: Null

### Example 6
```powershell
PS C:> New-ZertoVpg -vpgName "MyVpg" -protectedVm "WebServer01", "AppServer01", "DatabaseServer01" -recoverySite "Recovery Site" -recoveryFolder "Recovered VMs" -recoveryResourcePool "Recovery Resource Pool Name" -recoveryDatastoreCluster "Datastore Cluster Name" -testNetwork "Test Bubble Network" -recoveryNetwork "VM Network"
```

Creates a VPG Settings Object for a VPG called "MyVpg" and protecting Virtual Machines "WebServer01", "AppServer01", and "DatabaseServer01" targeting site "Recovery Site." The Virtual machines will be placed on the resource pool "Recovery Resource Pool Name" on the datastore cluster named "Datastore Cluster Name." When the virtual machines are created at the recovery site, they will be created in the folder "Recovered VMs." Finally, the network to be used during a live event will be "VM Network" and during a test operation will be "VM Network." Other values set will be the defaults, such as:

- VpgPriority: Medium
- JournalHistoryInHours: 24
- RpoInSeconds: 300
- TestIntervalInMinutes: 262080
- UseWanCompression: True
- ServiceProfile: Null
- Zorg: Null

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

### -journalDatastore
Name of the datastore to utilize to store Journal data. If not specified, the default datastore will be used.

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

### -journalHardLimitInMb
Default journal hard limit in megabytes. Default set to 153600 MB (150 GB). Set to 0 to set the journal to unlimited

```yaml
Type: UInt64
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 153600
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
Default value: 24
Accept pipeline input: False
Accept wildcard characters: False
```

### -journalWarningThresholdInMb
Default journal warning threshold in megabytes. If unset or greater than the hard limit, will be set to 75% of the journal hard limit. If the journalHardLimitInMB is set to 0 (unlimited), this will be set to unlimited as well.

```yaml
Type: UInt64
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
Default value: 300
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
Default value: 262080
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
Default value: True
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
Default value: Medium
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

### System.String
Vpg Settings Identifier

## NOTES

## RELATED LINKS

[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)
