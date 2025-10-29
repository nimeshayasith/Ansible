variable "admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "azureuser"
}

variable "allowed_ssh_ip" {
  description = "Your public IP for SSH access"
  type        = string
}
