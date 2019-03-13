---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: Invoke-ZertoMoveCommit.md
schema: 2.0.0
---

# Invoke-ZertoMoveCommit

## SYNOPSIS
Commit a VPG currently undergoing a move operation.

## SYNTAX

```
Invoke-ZertoMoveCommit [-vpgName] <String[]> [[-reverseProtect] <Boolean>] [-keepSourceVms]
 [<CommonParameters>]
```

## DESCRIPTION
Commit a VPG currently undergoing a move operation.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-ZertoMoveCommit -vpgName "MyVpg"
```

Commit VPG "MyVpg" after a move has been started.

## PARAMETERS

### -keepSourceVms
Use this switch to keep the source VMs.
If not set, they will be destroyed.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reverseProtect
Set this to True to reverse protect the VPG(s) to the source site.
If not set, will use selection made during move initiation.
True or False

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

### -vpgName
Name(s) of the VPG(s) to commit.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API VPG End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.100.html#)
