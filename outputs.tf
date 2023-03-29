output "id" {
  description = "The ID of this virtual machine"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine."
  value       = azurerm_linux_virtual_machine.vm.private_ip_address
}

output "principal_id" {
  description = "The Principal ID associated with this Managed Service Identity."
  value       = azurerm_linux_virtual_machine.vm.identity.0.principal_id
}
