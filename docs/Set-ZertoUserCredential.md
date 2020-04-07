---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Set-ZertoUserCredential.md
schema: 2.0.0
---

# Set-ZertoUserCredential

## SYNOPSIS
Allows the change or update of the credentials used to allow the Zerto Virtual Manager to connect and communicate with the paired Hypervisor.

## SYNTAX

```
Set-ZertoUserCredential [-UserCredential] <PSCredential> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows the change or update of the credentials used to allow the Zerto Virtual Manager to connect and communicate with the paired Hypervisor. A PSCredential object is required and will be used to pass the updated credentials.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-ZertoUserCredential -UserCredential $UserCredential
```

Will update the user account used to connect the Zerto Virtual Manager to the the paired Hypervisor.

## PARAMETERS

### -UserCredential
PSCredential Object that contains the username and password for the updated credentials.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

## OUTPUTS

## NOTES

## RELATED LINKS
[PSCredential Object Information](https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential)
