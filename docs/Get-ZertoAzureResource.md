---
external help file: ZertoApiWrapper-help.xml
Module Name: ZertoApiWrapper
online version: https://github.com/ZertoPublic/ZertoApiWrapper/blob/master/docs/Get-ZertoAzureResource.md
schema: 2.0.0
---

# Get-ZertoAzureResource

## SYNOPSIS
Function used to get data for the Azure site to populate VPGs targeting Azure. This information includes Networks (VNets), Subnets, Security Groups, and VM Instance Types.

## SYNTAX

### SiteNameVmInstanceType (Default)
```
Get-ZertoAzureResource -SiteName <String> [-VmInstanceType] [<CommonParameters>]
```

### SiteNameNetwork
```
Get-ZertoAzureResource -SiteName <String> [-Network] [<CommonParameters>]
```

### SiteNameSubnet
```
Get-ZertoAzureResource -SiteName <String> [-Subnet] [<CommonParameters>]
```

### SiteNameSecurityGroup
```
Get-ZertoAzureResource -SiteName <String> [-SecurityGroup] [<CommonParameters>]
```

### SiteIdentifierVmInstanceType
```
Get-ZertoAzureResource -SiteIdentifier <String> [-VmInstanceType] [<CommonParameters>]
```

### SiteIdentifierNetwork
```
Get-ZertoAzureResource -SiteIdentifier <String> [-Network] [<CommonParameters>]
```

### SiteIdentifierSubnet
```
Get-ZertoAzureResource -SiteIdentifier <String> [-Subnet] [<CommonParameters>]
```

### SiteIdentifierSecurityGroup
```
Get-ZertoAzureResource -SiteIdentifier <String> [-SecurityGroup] [<CommonParameters>]
```

## DESCRIPTION
Function used to get data for the Azure site to populate VPGs targeting Azure. This information includes Networks (VNets), Subnets, Security Groups, and VM Instance Types.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ZertoAzureResource -SiteName "My Azure Site" -Network
```

Returns information about the usable Networks (Vnets) at the Azure site with Zerto ZCA site named "My Azure Site"

### Example 2
```powershell
PS C:\> Get-ZertoAzureResource -SiteName "My Azure Site" -Subnet
```

Returns information about the usable Subnets at the Azure site with Zerto ZCA site named "My Azure Site"

### Example 3
```powershell
PS C:\> Get-ZertoAzureResource -SiteName "My Azure Site" -SecurityGroup
```

Returns information about the usable Security Groups at the Azure site with Zerto ZCA site named "My Azure Site"

### Example 4
```powershell
PS C:\> Get-ZertoAzureResource -SiteName "My Azure Site" -VmInstanceType
```

Returns information about the usable Vm Instance Types at the Azure site with Zerto ZCA site named "My Azure Site"

### Example 5
```powershell
PS C:\> Get-ZertoAzureResource -SiteIdentifier "0123-4142-152414" -Network
```

Returns information about the usable Networks (Vnets) at the Azure site with Zerto ZCA site with identifier "0123-4142-152414"

### Example 6
```powershell
PS C:\> Get-ZertoAzureResource -SiteIdentifier "0123-4142-152414" -Subnet
```

Returns information about the usable Subnets at the Azure site with Zerto ZCA site with identifier "0123-4142-152414"

### Example 7
```powershell
PS C:\> Get-ZertoAzureResource -SiteIdentifier "0123-4142-152414" -SecurityGroup
```

Returns information about the usable Security Groups at the Azure site with Zerto ZCA site with identifier "0123-4142-152414"

### Example 8
```powershell
PS C:\> Get-ZertoAzureResource -SiteIdentifier "0123-4142-152414" -VmInstanceType
```

Returns information about the usable Vm Instance Types at the Azure site with Zerto ZCA site with identifier "0123-4142-152414"

## PARAMETERS

### -Network
Use this switch to get information about the supported Networks (VNets).

```yaml
Type: SwitchParameter
Parameter Sets: SiteNameNetwork, SiteIdentifierNetwork
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SecurityGroup
Use this switch to get information about the supported Security Groups

```yaml
Type: SwitchParameter
Parameter Sets: SiteNameSecurityGroup, SiteIdentifierSecurityGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteIdentifier
Site Identifier of the Azure Site you wish to get the information.

```yaml
Type: String
Parameter Sets: SiteIdentifierVmInstanceType, SiteIdentifierNetwork, SiteIdentifierSubnet, SiteIdentifierSecurityGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
Name the Azure Site you wish to get the information.

```yaml
Type: String
Parameter Sets: SiteNameVmInstanceType, SiteNameNetwork, SiteNameSubnet, SiteNameSecurityGroup
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Subnet
Use this switch to get information about the supported Subnets

```yaml
Type: SwitchParameter
Parameter Sets: SiteNameSubnet, SiteIdentifierSubnet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -VmInstanceType
Use this switch to get information about the supported Vm Instance Types.

```yaml
Type: SwitchParameter
Parameter Sets: SiteNameVmInstanceType, SiteIdentifierVmInstanceType
Aliases:

Required: True
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
[ZVM Azure Resource API Endpoint Documentation](https://s3.amazonaws.com/zertodownload_docs/Latest/Zerto%20Virtual%20Replication%20Zerto%20Virtual%20Manager%20(ZVM)%20-%20vSphere%20Online%20Help/content/zvr_apis/virtualization_sites_api.htm#Availabl)
