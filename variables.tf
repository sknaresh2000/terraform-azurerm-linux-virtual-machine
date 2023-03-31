variable "name" {
  type        = string
  description = "Name of the Linux virtual machine"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where this VM will reside"
}

variable "location" {
  type        = string
  description = "Location of the virtual machine"
  default     = "eastus"
}

variable "size" {
  type        = string
  description = "The size of the virtual machine to be provisioned"
}

variable "admin_username" {
  type        = string
  description = "The name of the admin user that will be used to log in to the machine"
  default     = "azureuser"
}

variable "custom_data_script" {
  type        = string
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine."
  default     = null
}

variable "admin_password" {
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine. If not provided, disable_password_authentication should be set to true and keyvault id should be provided"
}

variable "disable_password_authentication" {
  type        = bool
  description = "Should Password Authentication be disabled on this Virtual Machine?"
  default     = false
}

variable "availability_set_id" {
  type        = string
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist."
  default     = null
}

variable "identity_type" {
  type        = string
  description = "Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned "
  default     = null
}

variable "identity_ids" {
  type        = list(string)
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine."
  default     = null
}

variable "os_disk_name" {
  type        = string
  description = "The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
}

variable "os_disk_caching" {
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
  default     = "None"
}

variable "os_disk_type" {
  type        = string
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
}

variable "source_image_reference" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  description = "The image that will be used to create this Linux virtual machine"
}

variable "source_image_id" {
  type        = string
  description = "The ID of the Image which this Virtual Machine should be created from"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags which should be assigned to the virtual machine"
}

variable "boot_diagnostics_storage_account_uri" {
  type        = string
  description = "The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  default     = null
}

variable "network_config" {
  type = map(object({
    name                          = string
    enable_accelerated_networking = bool         //Available only on selected sizes
    dns_servers                   = list(string) //optional. Mark it as null incase you want the default(VNET) config
    subnet_id                     = string
    private_ip_address_allocation = string //Can be Static or Dynamic. If Static, private_ip_address can be configured
    private_ip_address            = string //Mark it as null if private_ip_address_allocation is Dynamic
  }))
  description = "Details about the VM network configuration"
}

variable "data_disk_config" { //Mark it as null if any of the below parameters arent required
  type = map(object({
    name               = string
    disk_type          = string //The type of storage to use for the managed disk. Possible values are Standard_LRS, StandardSSD_ZRS, Premium_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS
    create_option      = string //The method to use when creating the managed disk. Options are Import, Empty, FromImage
    size               = number //size in gb
    image_reference_id = string //ID of an existing platform/marketplace disk image to copy when create_option is FromImage
    storage_account_id = string //The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import
    lun                = number //The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine
    caching            = string //Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite
  }))
  description = "Details about the data disks that needs to be attached. Optional"
  default     = {}
}

variable "network_interface_ids" {
  type        = list(string)
  description = "A list of Network Interface IDs which should be attached to this Virtual Machine. If ID's are not provided, the module will create and attach a NIC to the virtual machine."
  default     = null
}

variable "public_key" {
  type        = string
  description = "Public key for the virtual machine if disable password authentication is true"
  default     = null
}
