---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/wcarroll/ZertoApiWrapper/blob/master/docs/Get-ZertoVpgSetting.md
schema: 2.0.0
---

# Get-ZertoVpgSetting

## SYNOPSIS
Returns information when a VPG Settings object is created to create a new or edit an existing VPG.

## SYNTAX

### main (Default)
```
Get-ZertoVpgSetting [<CommonParameters>]
```

### volumeIdentifier
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> -vmIdentifier <String> -volumeIdentifier <String>
 [<CommonParameters>]
```

### volumes
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> -vmIdentifier <String> [-volumes] [<CommonParameters>]
```

### nicIdentifier
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> -vmIdentifier <String> -nicIdentifier <String>
 [<CommonParameters>]
```

### nics
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> -vmIdentifier <String> [-nics] [<CommonParameters>]
```

### vmIdentifier
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> -vmIdentifier <String> [<CommonParameters>]
```

### vms
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-vms] [<CommonParameters>]
```

### scripting
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-scripting] [<CommonParameters>]
```

### recovery
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-rcovery] [<CommonParameters>]
```

### priority
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-priority] [<CommonParameters>]
```

### networks
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-networks] [<CommonParameters>]
```

### journal
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-journal] [<CommonParameters>]
```

### bootGroup
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-bootgroup] [<CommonParameters>]
```

### basic
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-basic] [<CommonParameters>]
```

### schedulerPeriod
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-schedulerPeriod] [<CommonParameters>]
```

### retentionPeriod
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-retentionPeriod] [<CommonParameters>]
```

### dayOfWeek
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-dayOfWeek] [<CommonParameters>]
```

### backup
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [-backup] [<CommonParameters>]
```

### vpgSettingsIdentifier
```
Get-ZertoVpgSetting -vpgSettingsIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION
Returns information when a VPG Settings object is created to create a new or edit an existing VPG. Depending on the parameter set being called, the data returned will either be the entire VPG settings information, or if a specific part of the VPG is requested using a specific parameter set, then only that information will be returned.

It is important to note that only once a VPG settings object has been created, will this function return data.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoVpgSettings -vpgSettingsIdentifier "MySettingsIdentifier"
```

Returns all current settings for vpgSettingsIdentifier "MySettingsIdentifier"

### Example 2
```powershell
PS C:\> Get-ZertoVpgSettings -vpgSettingsIdentifier "MySettingsIdentifier" -vmIdentifier "MyVmId"
```

Returns all current vm level settings for the vmIdentifier "MyVmId" in vpgSettingsIdentifier "MySettingsIdentifier"

### Example 3
```powershell
PS C:\> Get-ZertoVpgSettings -vpgSettingsIdentifier "MySettingsIdentifier" -vmIdentifier "MyVmId" -volumes
```

Returns current vm level settings for volumes for vmId "MyVmId" in vpgSettingsIdentifier "MySettingsIdentifier"

### Example 4
```powershell
PS C:\> Get-ZertoVpgSettings -vpgSettingsIdentifier "MySettingsIdentifier" -nics
```

Returns current vm level settings for nics for vmId "MyVmId" in vpgSettingsIdentifier "MySettingsIdentifier"

### Example 5
```powershell
PS C:\> Get-ZertoVpgSettings -vpgSettingsIdentifier "MySettingsIdentifier" -basic
```

Returns current basic settings for vpgSettingsIdentifier "MySettingsIdentifier"

## PARAMETERS

### -backup
Return backup information for VPG identifier specified

```yaml
Type: SwitchParameter
Parameter Sets: backup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -basic
Get VPG Basic Settings

```yaml
Type: SwitchParameter
Parameter Sets: basic
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -bootgroup
Get VPG Boot Settings

```yaml
Type: SwitchParameter
Parameter Sets: bootGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -dayOfWeek
Get the day of week a backup is scheduled

```yaml
Type: SwitchParameter
Parameter Sets: dayOfWeek
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -journal
Get VPG Journal Settings

```yaml
Type: SwitchParameter
Parameter Sets: journal
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networks
Get VPG Network Settings

```yaml
Type: SwitchParameter
Parameter Sets: networks
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -nicIdentifier
Return NIC information for specified NIC of the specified VM

```yaml
Type: String
Parameter Sets: nicIdentifier
Aliases: nicId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -nics
Return NIC information for all NICs of the specified VM

```yaml
Type: SwitchParameter
Parameter Sets: nics
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
Get VPG Priority Settings

```yaml
Type: SwitchParameter
Parameter Sets: priority
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rcovery
Get VPG Recovery Settings

```yaml
Type: SwitchParameter
Parameter Sets: recovery
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -retentionPeriod
Get the retention period for a backup

```yaml
Type: SwitchParameter
Parameter Sets: retentionPeriod
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -schedulerPeriod
Get the backup schedule

```yaml
Type: SwitchParameter
Parameter Sets: schedulerPeriod
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -scripting
Get VPG Recovery Settings

```yaml
Type: SwitchParameter
Parameter Sets: scripting
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vmIdentifier
VM Identifier

```yaml
Type: String
Parameter Sets: volumeIdentifier, volumes, nicIdentifier, nics, vmIdentifier
Aliases: vmId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vms
Get all settings for all VMs in a VPG.

```yaml
Type: SwitchParameter
Parameter Sets: vms
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -volumeIdentifier
Return volume information for the specified volume of the specified VM

```yaml
Type: String
Parameter Sets: volumeIdentifier
Aliases: volumeId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -volumes
Return Volume information for all volumes of the specified VM

```yaml
Type: SwitchParameter
Parameter Sets: volumes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgSettingsIdentifier
The identifier of the VPG settings object for which information is retrieved.

```yaml
Type: String
Parameter Sets: volumeIdentifier, volumes, nicIdentifier, nics, vmIdentifier, vms, scripting, recovery, priority, networks, journal, bootGroup
Aliases: vpgSettingsId, settingsId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: basic, schedulerPeriod, retentionPeriod, dayOfWeek, backup, vpgSettingsIdentifier
Aliases: vpgSettingsId, settingsId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG Settings End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.108.html#)
