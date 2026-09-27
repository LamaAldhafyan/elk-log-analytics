output "vm_public_ip" {
  description = "Public IP address of the ELK virtual machine"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "vm_name" {
  description = "Name of the ELK virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}