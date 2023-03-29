resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.size
  admin_username                  = var.admin_username
  admin_password                  = var.disable_password_authentication ? null : var.admin_password
  custom_data                     = var.custom_data_script
  network_interface_ids           = var.network_interface_ids == null ? [for nic in azurerm_network_interface.nic : nic.id] : var.network_interface_ids
  availability_set_id             = var.availability_set_id
  source_image_id                 = length(var.source_image_reference) == 0 ? var.source_image_id : null
  disable_password_authentication = var.disable_password_authentication
  tags                            = var.tags

  boot_diagnostics {
    storage_account_uri = var.boot_diagnostics_storage_account_uri
  }

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = tls_private_key.tls[0].public_key_openssh
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }

  os_disk {
    name                 = var.os_disk_name
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id == null ? var.source_image_reference : {}
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
}

resource "azurerm_network_interface" "nic" {
  for_each                      = var.network_interface_ids == null ? var.network_config : {}
  name                          = each.value.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_servers                   = each.value.dns_servers
  enable_accelerated_networking = each.value.enable_accelerated_networking
  tags                          = var.tags

  ip_configuration {
    name                          = "ipc-${each.value.name}"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address            = each.value.private_ip_address
  }
}

resource "azurerm_managed_disk" "disk" {
  for_each             = var.data_disk_config
  name                 = each.value.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = each.value.disk_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.size
  image_reference_id   = each.value.image_reference_id
  storage_account_id   = each.value.storage_account_id
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  for_each           = var.data_disk_config
  managed_disk_id    = azurerm_managed_disk.disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  lun                = each.value.lun
  caching            = each.value.caching
}

resource "tls_private_key" "tls" {
  count     = var.disable_password_authentication ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "secret" {
  count        = var.disable_password_authentication ? 1 : 0
  name         = "${var.name}-key"
  value        = tls_private_key.tls[0].private_key_openssh
  key_vault_id = var.key_vault_id
}