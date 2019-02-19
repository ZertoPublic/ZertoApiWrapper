---
external help file: ZertoFunctions-help.xml
Module Name: ZertoFunctions
online version:
schema: 2.0.0
---

# Get-VpgSettings

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### default (Default)
```
Get-VpgSettings [<CommonParameters>]
```

### volumeIdentifier
```
Get-VpgSettings -vpgSettingsIdentifier <String> -vmIdentifier <String> -volumeIdentifier <String>
 [<CommonParameters>]
```

### volumes
```
Get-VpgSettings -vpgSettingsIdentifier <String> -vmIdentifier <String> [-volumes] [<CommonParameters>]
```

### nicIdentifier
```
Get-VpgSettings -vpgSettingsIdentifier <String> -vmIdentifier <String> -nicIdentifier <String>
 [<CommonParameters>]
```

### nics
```
Get-VpgSettings -vpgSettingsIdentifier <String> -vmIdentifier <String> [-nics] [<CommonParameters>]
```

### vmIdentifier
```
Get-VpgSettings -vpgSettingsIdentifier <String> -vmIdentifier <String> [<CommonParameters>]
```

### vms
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-vms] [<CommonParameters>]
```

### scripting
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-scripting] [<CommonParameters>]
```

### recovery
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-rcovery] [<CommonParameters>]
```

### priority
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-priority] [<CommonParameters>]
```

### networks
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-networks] [<CommonParameters>]
```

### journal
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-journal] [<CommonParameters>]
```

### bootGroup
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-bootgroup] [<CommonParameters>]
```

### basic
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-basic] [<CommonParameters>]
```

### schedulerPeriod
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-schedulerPeriod] [<CommonParameters>]
```

### retentionPeriod
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-retentionPeriod] [<CommonParameters>]
```

### dayOfWeek
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-dayOfWeek] [<CommonParameters>]
```

### backup
```
Get-VpgSettings -vpgSettingsIdentifier <String> [-backup] [<CommonParameters>]
```

### vpgSettingsIdentifier
```
Get-VpgSettings -vpgSettingsIdentifier <String> [<CommonParameters>]
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

### -backup
{{Fill backup Description}}

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
{{Fill basic Description}}

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
{{Fill bootgroup Description}}

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
{{Fill dayOfWeek Description}}

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
{{Fill journal Description}}

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
{{Fill networks Description}}

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
{{Fill nicIdentifier Description}}

```yaml
Type: String
Parameter Sets: nicIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -nics
{{Fill nics Description}}

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
{{Fill priority Description}}

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
{{Fill rcovery Description}}

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
{{Fill retentionPeriod Description}}

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
{{Fill schedulerPeriod Description}}

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
{{Fill scripting Description}}

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
{{Fill vmIdentifier Description}}

```yaml
Type: String
Parameter Sets: volumeIdentifier, volumes, nicIdentifier, nics, vmIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vms
{{Fill vms Description}}

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
{{Fill volumeIdentifier Description}}

```yaml
Type: String
Parameter Sets: volumeIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -volumes
{{Fill volumes Description}}

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
{{Fill vpgSettingsIdentifier Description}}

```yaml
Type: String
Parameter Sets: volumeIdentifier, volumes, nicIdentifier, nics, vmIdentifier, vms, scripting, recovery, priority, networks, journal, bootGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: basic, schedulerPeriod, retentionPeriod, dayOfWeek, backup, vpgSettingsIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
