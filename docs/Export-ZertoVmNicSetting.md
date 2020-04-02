---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/Master/docs/Export-ZertoVmNicSettings.md
schema: 2.0.0
---

# Export-ZertoVmNicSetting

## SYNOPSIS
Queries VPGs and associated Virtual Machines to export all protected virtual machine NIC settings to a Comma Separated Value (CSV) file.

## SYNTAX

```
Export-ZertoVmNicSetting [[-VpgName] <String[]>] [-OutputFile] <String> [<CommonParameters>]
```

## DESCRIPTION
Queries VPGs and associated Virtual Machines to export all protected virtual machine NIC settings to a Comma Separated Value (CSV) file. This file can be used with the Import-ZertoVmNicSetting function to bulk update.

## EXAMPLES

### Example 1
```powershell
PS C:\> Export-ZertoVmNicSetting -OutputFile "C:\ZertoInfo\VMNicSettings.csv"
```

Exports VM Nic Settings for ALL Virtual Protection Groups to a file located at "C:\ZertoInfo\VMNicSettings.csv"

### Example 2
```powershell
PS C:\> Export-ZertoVmNicSetting -OutputFile "C:\ZertoInfo\VMNicSettings.csv" -VpgName "Exchange", "Support Forum"
```

Exports VM Nic Settings for Exchange and Support Forum Virtual Protection Groups to a file located at "C:\ZertoInfo\VMNicSettings.csv"

## PARAMETERS

### -OutputFile
Output file information

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VpgName
Vpg(s) to export. If no VPG was named, all data will be exported.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
