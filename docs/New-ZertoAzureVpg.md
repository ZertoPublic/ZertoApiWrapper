---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/New-ZertoAzureVpg.md
schema: 2.0.0
---

# New-ZertoAzureVpg

## SYNOPSIS
Creates a New VPG Settings object targeting an Azure ZCA. A Zerto VPG Settings Identifier will be returned to as the VPG will need to be updated with the Virtual Machines that will be members of this VPG.

## SYNTAX

```
New-ZertoAzureVpg [-Name] <String> [[-Priority] <String>] [[-JournalHistoryInHours] <Int32>]
 [[-RpoInSeconds] <Int32>] [[-TestIntervalInMinutes] <Int32>] [[-UseWanCompression] <Boolean>]
 [-TargetSiteName] <String> [-LiveNetworkName] <String> [-LiveSubnetName] <String>
 [-LiveSecurityGroupName] <String> [-LiveInstanceType] <String> [[-LiveDiskType] <String>]
 [-TestNetworkName] <String> [-TestSubnetName] <String> [-TestSecurityGroupName] <String>
 [-TestInstanceType] <String> [[-TestDiskType] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates a New VPG Settings object targeting an Azure ZCA. A Zerto VPG Settings Identifier will be returned to as the VPG will need to be updated with the Virtual Machines that will be members of this VPG.

## EXAMPLES

### Example 1
```powershell
PS C:\> $VpgSettingsIdentifier = New-ZertoAzureVpg -Name "Example VPG" -Priority "Medium" -JournalHistoryInHours 24 -RpoInSeconds 300 -TestIntervalInMinutes 262080 -UseWanCompression $True -targetSiteName "My Azure Site" -liveNetworkName "Vnet_EastUS_Prod" -liveSubnetName "EUS-Subnet-1" -liveSecurityGroupName "SGP_East_Us_Prod" -LiveInstanceType "Standard_DS1_v2" -liveDiskType "ManagedPremiumSSD" -testNetworkName "Vnet_EastUS_Test" -testSubnetName "EUS-Subnet-2" -testSecurityGroupName "SGP_East_Us_Test" -testInstanceType "Standard_DS1_v2" -testDiskType "ManagedPremiumSSD"
```

Creates a VPG with the specified settings returning a Vpg Settings Identifier to the specified variable to be used in later steps creating the Vpg. All parameters are specified in this example.

### Example 2
```powershell
PS C:\> $VpgSettingsIdentifier = New-ZertoAzureVpg -Name "Example VPG" -targetSiteName "My Azure Site" -liveNetworkName "Vnet_EastUS_Prod" -liveSubnetName "EUS-Subnet-1" -liveSecurityGroupName "SGP_East_Us_Prod" -LiveInstanceType "Standard_DS1_v2" -testNetworkName "Vnet_EastUS_Test" -testSubnetName "EUS-Subnet-2" -testSecurityGroupName "SGP_East_Us_Test" -testInstanceType "Standard_DS1_v2"
```

Creates a VPG with the specified settings returning a Vpg Settings Identifier to the specified variable to be used in later steps creating the Vpg. Only mandatory parameters are specified in this example.

## PARAMETERS

### -JournalHistoryInHours
Desired journal history in hours of the VPG to be created.
Min 1 hour, Max 720 hours (30 days).
Default is 24 hours.

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

### -LiveDiskType
Type of disk to select as the default for the VPG during a live operation.
Default is 'ManagedPremiumSSD'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: UnmanagedStandard, ManagedPremiumSSD, ManagedStandardSSD, ManagedStandardHDD

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiveInstanceType
Name of the default VM Instance Type to use during a live operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiveNetworkName
Name of the default Network (VNet) to use during a live operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiveSecurityGroupName
Name of the default Security Group to use during a live operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiveSubnetName
Name of the default subnet to use during a live operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Desired name of the VPG to be created.

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

### -Priority
Replication priority of the VPG to be created.
Default value is 'Medium'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: High, Medium, Low

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RpoInSeconds
Desired RPO alert value in seconds.
Min 60 seconds, Max 86400 seconds (24 hours).
Default is 300 seconds (5 minutes).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetSiteName
Name of the ZCA site for the VPG to target.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestDiskType
Type of disk to select as the default for the VPG during a live operation.
Default is 'ManagedPremiumSSD'

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: UnmanagedStandard, ManagedPremiumSSD, ManagedStandardSSD, ManagedStandardHDD

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestInstanceType
Name of the default VM Instance Type to use during a test operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestIntervalInMinutes
Desired test interval in minutes.
Please review documentation for values.
Default is 262080 minutes (6 months).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 0, 43200, 131040, 262080, 394560, 525600

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestNetworkName
Name of the default Network (VNet) to use during a test operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestSecurityGroupName
Name of the default Security Group to use during a test operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestSubnetName
Name of the default subnet to use during a test operation.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseWanCompression
Turn on or off WAN compression.
Recommended this setting is not turned off.
Default is to leave WAN compression turned on.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

Vpg Settings Identifier

## NOTES

Please review the process and examples outlined in the [Wiki on GitHub](https://Need.ToAdd.link/To/Wiki) for full Vpg Creation workflow and required examples.

## RELATED LINKS

[Zerto Create Azure VPG Help Documentation](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20(ZVM)%20-%20vSphere%20Online%20Help/content/zvr_apis/vsphere_to_azure_vpg_management_apis.htm?tocpath=ZVR%20RESTful%20APIs%7CZerto%20APIs%7C_____26)
