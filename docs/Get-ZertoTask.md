---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoTask.md
schema: 2.0.0
---

# Get-ZertoTask

## SYNOPSIS
Returns information about tasks run on the site.

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
Returns information about tasks run on the site.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoTask
```

Returns all current Zerto tasks

### Example 1
```powershell
PS C:\> Get-ZertoTask -taskIdentifier "MyTaskIdentifier"
```

Returns information about task with taskIdentifier "MyTaskIdentifier"

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
The status of the task. Possible values are: 'InProgress', 'Paused', 'Failed', 'Completed', or 'Cancelling'

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
Aliases: taskId

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Task End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.076.html#)
