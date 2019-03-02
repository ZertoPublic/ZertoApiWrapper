---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoVpg

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-ZertoVpg [<CommonParameters>]
```

### stats
```
Get-ZertoVpg -protectionGroupIdentifier <String[]> [-checkpointsStats] [<CommonParameters>]
```

### checkpoints
```
Get-ZertoVpg -protectionGroupIdentifier <String[]> [-checkpoints] [-startDate <String>] [-endDate <String>]
 [<CommonParameters>]
```

### protectionGroupIdentifier
```
Get-ZertoVpg -protectionGroupIdentifier <String[]> [<CommonParameters>]
```

### entityTypes
```
Get-ZertoVpg [-entityTypes] [<CommonParameters>]
```

### failoverCommitPolicies
```
Get-ZertoVpg [-failoverCommitPolicies] [<CommonParameters>]
```

### failoverShutdownPolicies
```
Get-ZertoVpg [-failoverShutdownPolicies] [<CommonParameters>]
```

### priorities
```
Get-ZertoVpg [-priorities] [<CommonParameters>]
```

### retentionPolicies
```
Get-ZertoVpg [-retentionPolicies] [<CommonParameters>]
```

### statuses
```
Get-ZertoVpg [-statuses] [<CommonParameters>]
```

### subStatuses
```
Get-ZertoVpg [-subStatuses] [<CommonParameters>]
```

### filter
```
Get-ZertoVpg [-name <String>] [-status <String>] [-subStatus <String>] [-protectedSiteType <String>]
 [-recoverySiteType <String>] [-protectedSiteIdentifier <String>] [-recoverySiteIdentifier <String>]
 [-organizationName <String>] [-zorgIdentifier <String>] [-priority <String>]
 [-serviceProfileIdentifier <String>] [-backupEnabled] [<CommonParameters>]
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

### -backupEnabled
If backup is enabled.

```yaml
Type: SwitchParameter
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -checkpoints
Return checkpoints for the selected Virtual Protection Group.

```yaml
Type: SwitchParameter
Parameter Sets: checkpoints
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -checkpointsStats
Return earliest and latest checkpoints for the selected Virtual Protection Group

```yaml
Type: SwitchParameter
Parameter Sets: stats
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -endDate
Return checkpoints before the specified start date.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

```yaml
Type: String
Parameter Sets: checkpoints
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -entityTypes
Return Valid VPG entityTypes

```yaml
Type: SwitchParameter
Parameter Sets: entityTypes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -failoverCommitPolicies
Valid Failover Commit Policies

```yaml
Type: SwitchParameter
Parameter Sets: failoverCommitPolicies
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -failoverShutdownPolicies
Valid Failover Shutdown Policies

```yaml
Type: SwitchParameter
Parameter Sets: failoverShutdownPolicies
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
The name of the VPG.

```yaml
Type: String
Parameter Sets: filter
Aliases: vpgName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -organizationName
The ZORG for this VPG.

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

### -priorities
Valid VPG priorities

```yaml
Type: SwitchParameter
Parameter Sets: priorities
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -priority
The VPG priority.
Possible values are: '0' or 'Low', '1' or 'Medium', '2' or 'High'

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

### -protectedSiteIdentifier
The identifier of the protected site where the VPG virtual machines are protected.

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

### -protectedSiteType
The protected site environment.
This filter behaves in the same way as the sourceType filter.
Please see Zerto API Documentation for vaild values and discriptions.

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

### -protectionGroupIdentifier
The identifier(s) of the Virtual Protection Group to return

```yaml
Type: String[]
Parameter Sets: stats, checkpoints, protectionGroupIdentifier
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoverySiteIdentifier
The identifier of the protected site where the VPG virtual machines are recovered.

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

### -recoverySiteType
The recovery site environment.
This filter behaves in the same way as the sourceType filter.
Please see Zerto API Documentation for vaild values and discriptions.

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

### -retentionPolicies
Valid retention policies

```yaml
Type: SwitchParameter
Parameter Sets: retentionPolicies
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serviceProfileIdentifier
The identifier of the service profile to use for the VPG when a Zerto Cloud Manager is used.

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

### -startDate
Return checkpoints after the specified start date.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

```yaml
Type: String
Parameter Sets: checkpoints
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
The status of the VPG.
Please use 'Get-ZertoVpg -statuses' for valid values

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
Valid VPG statuses

```yaml
Type: SwitchParameter
Parameter Sets: statuses
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -subStatus
The substatus of the VPG.
Please use 'Get-ZertoVpg -substatuses' for valid values

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

### -subStatuses
Valid VPG sub statuses

```yaml
Type: SwitchParameter
Parameter Sets: subStatuses
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zorgIdentifier
The internal identifier for the ZORG.

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
