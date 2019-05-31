---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Edit-ZertoVra.md
schema: 2.0.0
---

# Edit-ZertoVra

## SYNOPSIS
Updates a VRA with updated settings

## SYNTAX

```
Edit-ZertoVra -vraIdentifier <String> [-groupName <String>] [-vraIpAddress <String>] [-defaultGateway <String>]
 [-subnetMask <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a VRA with updated settings using the Zerto VRA end point.

It is possible to update the Bandwidth group with the -groupName setting. If the group does not currently exist, it will be created.

It is possible to update the static IP address, default gateway, or subnetmask.

It is suggested that you use Get-ZertoVra to get the vraIdentifer parameter.

## EXAMPLES

### Example 1
```powershell
PS C:\> Edit-ZertoVra -vraIdentifier $vraIdentifier -groupName "My Group Name"
```

Updates the VRA Group Name to "My Group Name"

### Example 2
```powershell
PS C:\>Edit-ZertoVra -vraIdentifier $vraIdentifier -vraIpAddress "192.168.1.101"
```

Updates the VRA IP address to "192.168.1.101"

### Example 3
```powershell
PS C:\>Edit-ZertoVra -vraIdentifier $vraIdentifier -vraIpAddress "192.168.1.101" -subnetMask "255.255.252.0" -defaultGateway "192.168.1.1"
```

Updates the VRA IP address to 192.168.1.101, subnet mask to 255.255.252.0, and default gateway to 192.168.1.1

### Example 3
```powershell
PS C:\>Edit-ZertoVra -vraIdentifier $vraIdentifier -defaultGateway "192.168.1.1"
```

Updates the VRA default gateway to 192.168.1.1

## PARAMETERS

### -defaultGateway
Default gateway to assign to the VRA

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

### -groupName
Bandwidth group to assign to the VRA.
If unspecified will not modify current assignment

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

### -subnetMask
Subnetmask to be assigned to the VRA

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

### -vraIdentifier
Identifier of the VRA to be updated.

```yaml
Type: String
Parameter Sets: (All)
Aliases: vraId

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vraIpAddress
Static IP address to assign to the VRA.

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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VRA End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.117.html#)
