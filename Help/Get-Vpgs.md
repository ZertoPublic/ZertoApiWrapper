---
external help file: ZertoFunctions-help.xml
Module Name: ZertoFunctions
online version:
schema: 2.0.0
---

# Get-Vpgs

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-Vpgs [<CommonParameters>]
```

### stats
```
Get-Vpgs -protectionGroupIdentifier <String[]> [-checkpointsStats] [<CommonParameters>]
```

### checkpoints
```
Get-Vpgs -protectionGroupIdentifier <String[]> [-checkpoints] [-startDate <String>] [-endDate <String>]
 [<CommonParameters>]
```

### protectionGroupIdentifier
```
Get-Vpgs -protectionGroupIdentifier <String[]> [<CommonParameters>]
```

### entityTypes
```
Get-Vpgs [-entityTypes] [<CommonParameters>]
```

### failoverCommitPolicies
```
Get-Vpgs [-failoverCommitPolicies] [<CommonParameters>]
```

### failoverShutdownPolicies
```
Get-Vpgs [-failoverShutdownPolicies] [<CommonParameters>]
```

### priorities
```
Get-Vpgs [-priorities] [<CommonParameters>]
```

### retentionPolicies
```
Get-Vpgs [-retentionPolicies] [<CommonParameters>]
```

### statuses
```
Get-Vpgs [-statuses] [<CommonParameters>]
```

### subStatuses
```
Get-Vpgs [-subStatuses] [<CommonParameters>]
```

### filter
```
Get-Vpgs [-name <String>] [-status <String>] [-subStatus <String>] [-protectedSiteType <String>]
 [-recoverySiteType <String>] [-protectedSiteIdentifier <String>] [-recoverySiteIdentifier <String>]
 [-organizationName <String>] [-zorgIdentifier <String>] [-priority <String>]
 [-serviceProfileIdentifier <String>] [-backupEnabled <String>] [<CommonParameters>]
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
{{Fill backupEnabled Description}}

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

### -checkpoints
{{Fill checkpoints Description}}

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
{{Fill checkpointsStats Description}}

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
{{Fill endDate Description}}

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
{{Fill entityTypes Description}}

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
{{Fill failoverCommitPolicies Description}}

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
{{Fill failoverShutdownPolicies Description}}

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
{{Fill name Description}}

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

### -organizationName
{{Fill organizationName Description}}

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
{{Fill priorities Description}}

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
{{Fill priority Description}}

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
{{Fill protectedSiteIdentifier Description}}

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
{{Fill protectedSiteType Description}}

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
{{Fill protectionGroupIdentifier Description}}

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
{{Fill recoverySiteIdentifier Description}}

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
{{Fill recoverySiteType Description}}

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
{{Fill retentionPolicies Description}}

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
{{Fill serviceProfileIdentifier Description}}

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
{{Fill startDate Description}}

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
{{Fill status Description}}

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
{{Fill statuses Description}}

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
{{Fill subStatus Description}}

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
{{Fill subStatuses Description}}

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
{{Fill zorgIdentifier Description}}

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
