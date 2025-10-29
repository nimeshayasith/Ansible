output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "vm_public_ips" {
  description = "Public IP addresses of VMs (for Ansible inventory)"
  value = {
    for idx in range(var.vm_count) : idx => {
      vm_name    = azurerm_linux_virtual_machine.main[idx].name
      role       = var.vm_roles[idx]
      public_ip  = azurerm_public_ip.main[idx].ip_address
      private_ip = azurerm_linux_virtual_machine.main[idx].private_ip_address
    }
  }
}

output "ansible_inventory_ips" {
  description = "Public IPs in order for inventory.ini"
  value = [
    for idx in range(var.vm_count) : azurerm_public_ip.main[idx].ip_address
  ]
}

output "vm_details_by_role" {
  description = "VM details grouped by role"
  value = {
    web = [
      for idx, vm in azurerm_linux_virtual_machine.main : {
        name       = vm.name
        public_ip  = azurerm_public_ip.main[idx].ip_address
        private_ip = vm.private_ip_address
      }
      if var.vm_roles[idx] == "web"
    ]
    app = [
      for idx, vm in azurerm_linux_virtual_machine.main : {
        name       = vm.name
        public_ip  = azurerm_public_ip.main[idx].ip_address
        private_ip = vm.private_ip_address
      }
      if var.vm_roles[idx] == "app"
    ]
    db = [
      for idx, vm in azurerm_linux_virtual_machine.main : {
        name       = vm.name
        public_ip  = azurerm_public_ip.main[idx].ip_address
        private_ip = vm.private_ip_address
      }
      if var.vm_roles[idx] == "db"
    ]
  }
}

output "ssh_commands" {
  description = "SSH commands to connect to each VM"
  value = {
    for idx in range(var.vm_count) : 
    azurerm_linux_virtual_machine.main[idx].name => 
    "ssh -i ~/.ssh/id_ed25519 ${var.admin_username}@${azurerm_public_ip.main[idx].ip_address}"
  }
}
