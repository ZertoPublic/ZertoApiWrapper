---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Install-ZertoVra

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### Dhcp
```
Install-ZertoVra -hostName <String> -datastoreName <String> -networkName <String> [-memoryInGB <Int32>]
 [-groupName <String>] [-Dhcp] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### StaticIp
```
Install-ZertoVra -hostName <String> -datastoreName <String> -networkName <String> [-memoryInGB <Int32>]
 [-groupName <String>] -vraIpAddress <String> -defaultGateway <String> -subnetMask <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
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

### -datastoreName
Datastore name where the VRA is to be installed.

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

### -defaultGateway
Default gateway to assign to the VRA

```yaml
Type: String
Parameter Sets: StaticIp
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Dhcp
Assign a DHCP address to the VRA.

```yaml
Type: SwitchParameter
Parameter Sets: Dhcp
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -groupName
Bandwidth group to assign to the VRA.
If unspecified will assign to the 'default_group'

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

### -hostName
Host name where the VRA is to be installed.

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

### -memoryInGB
Initial amount of memory to assign to the VRA in GB.
Default is 3, Minimum is 1, Maximum is 16

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

### -networkName
Network name the VRA is to be assigned.

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

### -subnetMask
Subnetmask to be assigned to the VRA

```yaml
Type: String
Parameter Sets: StaticIp
Aliases:

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
Parameter Sets: StaticIp
Aliases:

Required: True
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
