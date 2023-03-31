## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.disk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.disk_attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this Virtual Machine. If not provided, disable\_password\_authentication should be set to true and keyvault id should be provided | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The name of the admin user that will be used to log in to the machine | `string` | `"azureuser"` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | Specifies the ID of the Availability Set in which the Virtual Machine should exist. | `string` | `null` | no |
| <a name="input_boot_diagnostics_storage_account_uri"></a> [boot\_diagnostics\_storage\_account\_uri](#input\_boot\_diagnostics\_storage\_account\_uri) | The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. | `string` | `null` | no |
| <a name="input_custom_data_script"></a> [custom\_data\_script](#input\_custom\_data\_script) | The Base64-Encoded Custom Data which should be used for this Virtual Machine. | `string` | `null` | no |
| <a name="input_data_disk_config"></a> [data\_disk\_config](#input\_data\_disk\_config) | Details about the data disks that needs to be attached. Optional | <pre>map(object({<br>    name               = string<br>    disk_type          = string //The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS<br>    create_option      = string //The method to use when creating the managed disk. Options are Import, Empty, FromImage<br>    size               = number //size in gb<br>    image_reference_id = string //ID of an existing platform/marketplace disk image to copy when create_option is FromImage<br>    storage_account_id = string //The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import<br>    lun                = number //The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine<br>    caching            = string //Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite<br>  }))</pre> | `{}` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Should Password Authentication be disabled on this Virtual Machine? | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine. | `list(string)` | `null` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the virtual machine | `string` | `"eastus"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Linux virtual machine | `string` | n/a | yes |
| <a name="input_network_config"></a> [network\_config](#input\_network\_config) | Details about the VM network configuration | <pre>map(object({<br>    name                          = string<br>    enable_accelerated_networking = bool         //Available only on selected sizes<br>    dns_servers                   = list(string) //optional. Mark it as null incase you want the default(VNET) config<br>    subnet_id                     = string<br>    private_ip_address_allocation = string //Can be Static or Dynamic. If Static, private_ip_address can be configured<br>    private_ip_address            = string //Mark it as null if private_ip_address_allocation is Dynamic<br>  }))</pre> | n/a | yes |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | A list of Network Interface IDs which should be attached to this Virtual Machine. If ID's are not provided, the module will create and attach a NIC to the virtual machine. | `list(string)` | `null` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite | `string` | `"None"` | no |
| <a name="input_os_disk_name"></a> [os\_disk\_name](#input\_os\_disk\_name) | The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. | `number` | n/a | yes |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS, Premium\_LRS, StandardSSD\_ZRS and Premium\_ZRS | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public key for the virtual machine if disable password authentication is true | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group where this VM will reside | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The size of the virtual machine to be provisioned | `string` | n/a | yes |
| <a name="input_source_image_id"></a> [source\_image\_id](#input\_source\_image\_id) | The ID of the Image which this Virtual Machine should be created from | `string` | `null` | no |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | The image that will be used to create this Linux virtual machine | <pre>map(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the virtual machine | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of this virtual machine |
| <a name="output_principal_id"></a> [principal\_id](#output\_principal\_id) | The Principal ID associated with this Managed Service Identity. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The Primary Private IP Address assigned to this Virtual Machine. |
