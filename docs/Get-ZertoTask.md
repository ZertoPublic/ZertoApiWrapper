---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version:
schema: 2.0.0
---

# Get-ZertoTask

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### main (Default)
```
Get-ZertoTask [<CommonParameters>]
```

### taskIdentifier
```
Get-ZertoTask [-taskIdentifier <String[]>] [<CommonParameters>]
```

### types
```
Get-ZertoTask [-types] [<CommonParameters>]
```

### filter
```
Get-ZertoTask [-startedBeforeDate <String>] [-startedAfterDate <String>] [-completedAfterDate <String>]
 [-completedBeforeDate <String>] [-type <String>] [-status <String>] [<CommonParameters>]
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

### -completedAfterDate
Tasks completed after this time (inclusive) are displayed.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

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

### -completedBeforeDate
Tasks completed before this time (inclusive) are displayed.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

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

### -startedAfterDate
Tasks started after this time (inclusive) are displayed.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

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

### -startedBeforeDate
Tasks started before this time (inclusive) are displayed.
Valid formats include: 'yyyy-MM-ddTHH:mm:ss.fffZ', 'yyyy-MM-ddTHH:mm:ssZ', 'yyyy-MM-ddTHH:mmZ', 'yyyy-MM-ddTHHZ', 'yyyy-MM-dd', 'yyyy-MM', 'yyyy'.
Adding Z to the end of the time sets the time to UTC.

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
The status of the task.
Possible values are: '1' or 'InProgress', '3' or 'Paused', '4' or 'Failed', '6' or 'Completed', '7' or 'Cancelling'

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

### -taskIdentifier
The identifier(s) for which task information is to be returned.

```yaml
Type: String[]
Parameter Sets: taskIdentifier
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
The type of task.
For the description of the tasks, refer to the Zerto Virtual Replication documentation about monitoring tasks.
Please see Zerto API Documentation for possible types and values.

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

### -types
Returns all task types.

```yaml
Type: SwitchParameter
Parameter Sets: types
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
[Zerto REST API Task End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.076.html#)
