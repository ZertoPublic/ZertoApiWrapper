---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZAProtectedVm.md
schema: 2.0.0
---

# Get-ZAProtectedVm

## SYNOPSIS
Gets information about currently protected Virtual Machines in all sites. If desired a subset of VMs can be returned by providing VM Identifiers for each virtual machine.

## SYNTAX

### AllVMs (Default)
```
Get-ZAProtectedVm [-AllVms] [<CommonParameters>]
```

### IndividualVMs
```
Get-ZAProtectedVm -VMIdentifier <String[]> [-Volumes] [<CommonParameters>]
```

## DESCRIPTION
Gets information about currently protected Virtual Machines in all sites. If desired a subset of VMs can be returned by providing VM Identifiers for each virtual machine. Finally, when gathering information for individual virtual machines, the `-Volumes` parameter can be specified to return volume information for the protected VM.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZAProtectedVm
```

Returns all protected virtual machines across all sites.

### Example 2
```powershell
PS C:\> Get-ZAProtectedVm -AllVMs
```

Returns all protected virtual machines across all sites.

### Example 3
```powershell
PS C:\> Get-ZAProtectedVm -VMIdentifier '09914-12345-12341235', '81238-12532-12355332'
```

Returns information for only the two specified virtual machines

### Example 4
```powershell
PS C:\> Get-ZAProtectedVm -VMIdentifier '09914-12345-12341235', '81238-12532-12355332' -Volumes
```

Returns volume information for the two specified virtual machines

## PARAMETERS

### -AllVms
Use this switch when you want a list of all protected VMs.
Please be warned this list can be quite large.

```yaml
Type: SwitchParameter
Parameter Sets: AllVMs
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -VMIdentifier
A list of VM identifiers to query

```yaml
Type: String[]
Parameter Sets: IndividualVMs
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Volumes
Specify this switch when you would like protected vms' volume information returned

```yaml
Type: SwitchParameter
Parameter Sets: IndividualVMs
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics Protected VMs API Endpoint - AllVMs](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_protected_vms)
[Zerto Analytics Protected VMs API Endpoint - List of VMs](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_protected_vms__vmIdentifier_)
[Zerto Analytics Protected VMs API Endpoint - Volumes of VMs](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_protected_vms__vmIdentifier__volumes)

