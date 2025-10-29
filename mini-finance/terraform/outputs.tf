output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "admin_user" {
  description = "Admin username for SSH"
  value       = var.admin_username
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i ~/.ssh/id_rsa_azure ${var.admin_username}@${azurerm_public_ip.pip.ip_address}"
}

output "http_url" {
  description = "URL to access the website"
  value       = "http://${azurerm_public_ip.pip.ip_address}"
}
