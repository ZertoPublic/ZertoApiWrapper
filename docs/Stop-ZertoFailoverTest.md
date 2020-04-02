---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Stop-ZertoFailoverTest.md
schema: 2.0.0
---

# Stop-ZertoFailoverTest

## SYNOPSIS
Stops a running Failover Test operation.

## SYNTAX

```
Stop-ZertoFailoverTest [-vpgName] <String[]> [[-failoverTestSuccess] <Boolean>]
 [[-failoverTestSummary] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stops a running Failover Test operation.

## EXAMPLES

### Example 1
```powershell
PS C:\> Stop-ZertoFailoverTest -vpgName "MyVpg" -failoverTestSummary "All Good"
```

Stop Failover Test for virtual protection group "MyVpg" indicating a success and making a note of "All Good"

## PARAMETERS

### -failoverTestSuccess
Was the test successful?
True or False.
True is Default.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -failoverTestSummary
Free text field for any notes to add to the test report.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name(s) of VPG(s) to stop testing.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
