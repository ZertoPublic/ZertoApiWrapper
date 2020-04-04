---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/New-ZertoPairingToken.md
schema: 2.0.0
---

# New-ZertoPairingToken

## SYNOPSIS
Generates a new pairing token to be used during pairing ZVM to ZVM operations.

## SYNTAX

```
New-ZertoPairingToken [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generates a new pairing token to be used during pairing ZVM to ZVM operations. This token is valid until used or 48 hours have passed, whichever comes first. This feature is only required when pairing two Zerto sites that are both operating Zerto version 7.5 or greater. To use this feature you will need to generate a pairing token from the destination site. Once that token is generated you will use that token to pair the source site to the destination site either via the GUI or via the `Add-ZertoPeerSite` function.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-ZertoPairingToken
```

Generates an object that will contain the pairing token and expiration date and time.

## PARAMETERS

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Peer Sites End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/index.html#page/RestfulAPIs%2FStatusAPIs.5.046.html%23)
