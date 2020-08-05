---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Add-ZertoVpgVm.md
schema: 2.0.0
---

# Add-ZertoVpgVm

## SYNOPSIS
Adds one or more virtual machines to an existing VPG. A VPG Settings Identifier will be returned for use in either further customization of the VPG or passed to the `Save-ZertoVpgSetting` command to commit the changes.

## SYNTAX

### VpgName (Default)
```
Add-ZertoVpgVm -VpgName <String> -Vm <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### VpgSettingsIdentifier
```
Add-ZertoVpgVm -vpgSettingsIdentifier <String> -Vm <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds one or more virtual machines to an existing VPG. A VPG Settings Identifier will be returned for use in either further customization of the VPG or passed to the `Save-ZertoVpgSetting` command to commit the changes.

Internal logic to the function will only process unique items and ensure that VMs meet requirements to replicate to the target site. These requirements include not currently a member of the specified VPG, not currently replicating to the target site, and not a member of 3 or more VPGs.

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-ZertoVpgVm -VpgSettingsIdentifier $vpgSettingsIdentifier -Vm "VM 1", "Vm 2"
```

Adds "VM 1" and "VM 2" to the Vpg with VpgSettingsIdentifer specified in `$VpgSettingsIdentifier`. This variable was obtained via other functions that create and return a Vpg Settings Identifier. The Vpg Settings Identifier passed into the function will be returned.

### Example 2
```powershell
PS C:\> Add-ZertoVpgVm -VpgName "My Vpg" -Vm "VM 1", "Vm 2"
```

Adds "VM 1" and "VM 2" to the Vpg named "My Vpg". In this case, a new Vpg Settings Identifier will be created and returned.

## PARAMETERS

### -Vm
Name of VM(s) to add to the VPG

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

### -VpgName
Target VPG Name to Add the VM

```yaml
Type: String
Parameter Sets: VpgName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgSettingsIdentifier
Vpg Settings Identifier

```yaml
Type: String
Parameter Sets: VpgSettingsIdentifier
Aliases: sid, settingsIdentifier, vpgSettingsId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
[Adding VMs to a VPG Settings Object](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20(ZVM)%20-%20vSphere%20Online%20Help/content/zvr_apis/vpg_management_api.htm?tocpath=ZVR%20RESTful%20APIs%7CZerto%20APIs%7C_____20#statusapis_4057192544_1358357)
