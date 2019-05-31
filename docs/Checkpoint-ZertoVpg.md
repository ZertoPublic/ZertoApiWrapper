---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Checkpoint-ZertoVpg.md
schema: 2.0.0
---

# Checkpoint-ZertoVpg

## SYNOPSIS
Add a tagged checkpoint to a specified VPG

## SYNTAX

```
Checkpoint-ZertoVpg [-vpgName] <String> [-checkpointName] <String> [<CommonParameters>]
```

## DESCRIPTION
Add a tagged checkpoint to a specified VPG

## EXAMPLES

### Example 1
```powershell
PS C:\> Checkpoint-ZertoVpg -vpgName "Example VPG" -checkpointName "My Tagged Checkpoint"
```

Adds a tagged checkpoint to the "Example VPG" with the checkpoint name of "My Tagged Checkpoint"

## PARAMETERS

### -checkpointName
Text to tag the checkpoint with.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -vpgName
Name of the VPG to tag.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
