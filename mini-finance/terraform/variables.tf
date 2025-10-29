variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "mini-finance-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "mini-finance-vm"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa_azure.pub"
}
