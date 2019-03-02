---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoVra

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-ZertoVra [<CommonParameters>]
```

### ipConfigurationTypes
```
Get-ZertoVra [-ipconfigurationtypes] [<CommonParameters>]
```

### statuses
```
Get-ZertoVra [-statuses] [<CommonParameters>]
```

### vraIdentifier
```
Get-ZertoVra [-vraIdentifier <String[]>] [<CommonParameters>]
```

### filter
```
Get-ZertoVra [-vraName <String>] [-status <String>] [-vraVersion <String>] [-hostVersion <String>]
 [-ipAddress <String>] [-vraGroup <String>] [-datastoreName <String>] [-datastoreClusterName <String>]
 [-networkName <String>] [<CommonParameters>]
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

### -datastoreClusterName
Search for VRAs on a specific datastore cluster

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -datastoreName
Search for VRAs on a specific datastore

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hostVersion
Search for VRAs paired to a specific host version

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ipAddress
Search for a VRA with the specified IP address

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ipconfigurationtypes
Returns Valid VRA IP configuration types

```yaml
Type: SwitchParameter
Parameter Sets: ipConfigurationTypes
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -networkName
Search for VRAs on a specific network

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Search for VRAs in a specific status

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -statuses
Returns Valid VRA statuses

```yaml
Type: SwitchParameter
Parameter Sets: statuses
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vraGroup
Search for VRAs belonging to a specific group

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vraIdentifier
Returns information for provided VRA identifier(s)

```yaml
Type: String[]
Parameter Sets: vraIdentifier
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vraName
VRA Name to return information for.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vraVersion
Search for VRAs of a specific version

```yaml
Type: String
Parameter Sets: filter
Aliases:

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
