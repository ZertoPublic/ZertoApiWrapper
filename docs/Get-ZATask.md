---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZATask.md
schema: 2.0.0
---

# Get-ZATask

## SYNOPSIS

Retrieve details of all existing tasks.

## SYNTAX

### zOrg (Default)
```
Get-ZATask [-zOrgIdentifier <String>] [-limitTo <Int32>] [<CommonParameters>]
```

### taskId
```
Get-ZATask -taskIdentifier <String> [<CommonParameters>]
```

## DESCRIPTION

Retrieve details of all existing tasks.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZATask
```

Retrieve details of all existing tasks.

### Example 2
```powershell
PS C:\> Get-ZATask -zOrgIdentifier "1234-5678-9012"
```

Retrieve details of all existing tasks for zOrg with Identifier "1234-5678-9012".

### Example 1
```powershell
PS C:\> Get-ZATask -taskIdentifier "9012-3456-7890"
```

Retrieve details of a specific task with identifier "9012-3456-7890".

## PARAMETERS

### -limitTo
The maximum number of tasks to return.

```yaml
Type: Int32
Parameter Sets: zOrg
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -taskIdentifier
The task Idnetifier

```yaml
Type: String
Parameter Sets: taskId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -zOrgIdentifier
The ZORG identifier by which to filter the task list.
If the ZORG identifier is omitted, a list of all the tasks is retrieved.

```yaml
Type: String
Parameter Sets: zOrg
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Zerto Analytics REST API Endpoint for Tasks](https://docs.api.zerto.com/#/Monitoring/get_v2_monitoring_tasks)
