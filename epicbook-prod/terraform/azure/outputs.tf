output "public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.main.ip_address
}

output "admin_user" {
  description = "Admin username"
  value       = var.admin_username
}

output "ssh_command" {
  description = "SSH command to connect"
  value       = "ssh -i ${abspath(path.module)}/epicbook_key.pem ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "private_key_path" {
  description = "Path to SSH private key"
  value       = abspath("${path.module}/epicbook_key.pem")
}
