---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoProtectedVm.md
schema: 2.0.0
---

# Get-ZertoProtectedVm

## SYNOPSIS
Returns information about Virtual Machines protected by Zerto

## SYNTAX

### main (Default)
```
Get-ZertoProtectedVm [<CommonParameters>]
```

### vmIdentifier
```
Get-ZertoProtectedVm -vmIdentifier <String[]> [<CommonParameters>]
```

### filter
```
Get-ZertoProtectedVm [-vpgName <String>] [-vmName <String>] [-status <String>] [-substatus <String>]
 [-organizationName <String>] [-priority <String>] [-protectedSiteType <String>] [-recoverySiteType <String>]
 [-protectedSiteIdentifier <String>] [-recoverySiteIdentifier <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns information about virtual machines protected by Zerto. When called without parameters, will return all currently protected virtual machines. A single vmIdentifier or an array of vmIdentifiers can be used to only return information about those virtual machines.

If information is wanted for several virtual machines and you need to search for those machines, any of the parameters in the Filter parameter set can be used to find virtual machines that fit all the criteria passed to the function.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoProtectedVm
```

Returns all virtual machines that are either protected to or protected from this site by Zerto

### Example 1
```powershell
PS C:\> Get-ZertoProtectedVm -vmIdentifier "MyVmIdentifier"
```

Returns information about the protected virtual machine with identifier "MyVmIdentifier"

### Example 1
```powershell
PS C:\> Get-ZertoProtectedVm -vmIdentifier "MyVmIdentifier", "MyOtherVmIdentifier"
```

Returns information about the protected virtual machines with identifiers "MyVmIdentifier" and "MyOtherVmIdentifier"

### Example 1
```powershell
PS C:\> Get-ZertoProtectedVm -vpgName "My Vpg"
```

Returns all virtual machines that are members of the Virtual Protection Group "My Vpg"

## PARAMETERS

### -organizationName
The ZORG for this VPG.

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

### -priority
The priority specified for the VPG. Possible values are: 'Low', 'Medium', or 'High'

```yaml
Type: String
Parameter Sets: filter
Aliases:
Accepted values: Low, Medium, High

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -protectedSiteIdentifier
The identifier of the protected site where the VPG virtual machines are protected.

```yaml
Type: String
Parameter Sets: filter
Aliases: protectedSiteId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -protectedSiteType
The protected site type.
Please see Zerto API documentation for possible values.

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

### -recoverySiteIdentifier
The identifier of the recovery site where the VPG virtual machines are recovered.

```yaml
Type: String
Parameter Sets: filter
Aliases: recoverySiteId

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -recoverySiteType
The recovery site type.
Please see Zerto API documentation for possible values.

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
The status of the VPG.
Please see Zerto API documentation for possible values.

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

### -substatus
The substatus of the VPG, for example the VPG is in a bitmap sync.
For the description of substatuses, refer to the Zerto Virtual Manager Administration Guide.
Please see Zerto API documentation for possible values.

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

### -vmIdentifier
vmIdentifier(s) for which to return information

```yaml
Type: String[]
Parameter Sets: vmIdentifier
Aliases: vmId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -vmName
The name of the virtual machine.

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

### -vpgName
The name of the VPG which protects the virtual machine.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Zerto REST API Protected VMs End Point Documentation](http://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20%28ZVM%29%20-%20vSphere%20Online%20Help/RestfulAPIs/StatusAPIs.5.088.html#)
