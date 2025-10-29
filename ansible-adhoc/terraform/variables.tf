variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "ansible-adhoc-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "canadacentral"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa_azure.pub"
}

variable "vm_roles" {
  description = "Roles for each VM (used for tagging and grouping)"
  type        = list(string)
  default     = ["web", "app", "db"]
}
