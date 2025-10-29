# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = "Development"
    Project     = "Ansible-AdHoc"
    ManagedBy   = "Terraform"
    Assignment  = "Task-34"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "ansible-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = azurerm_resource_group.main.tags
}

# Subnet
resource "azurerm_subnet" "main" {
  name                 = "ansible-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "ansible-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Allow SSH from anywhere (for lab environment)
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow HTTP (for NGINX web servers)
  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = azurerm_resource_group.main.tags
}

# Public IPs
resource "azurerm_public_ip" "main" {
  count               = var.vm_count
  name                = "ansible-pip-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(
    azurerm_resource_group.main.tags,
    {
      Role  = var.vm_roles[count.index]
      Index = count.index
    }
  )
}

# Network Interfaces
resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "ansible-nic-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[count.index].id
  }

  tags = merge(
    azurerm_resource_group.main.tags,
    {
      Role  = var.vm_roles[count.index]
      Index = count.index
    }
  )
}

# Associate NSG with NICs
resource "azurerm_network_interface_security_group_association" "main" {
  count                     = var.vm_count
  network_interface_id      = azurerm_network_interface.main[count.index].id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Virtual Machines
resource "azurerm_linux_virtual_machine" "main" {
  count               = var.vm_count
  name                = "ansible-vm-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.main[count.index].id
  ]

  # SSH public key authentication (passwordless)
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(pathexpand(var.ssh_public_key_path))
  }

  # Disable password authentication (security best practice)
  disable_password_authentication = true

  os_disk {
    name                 = "ansible-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = merge(
    azurerm_resource_group.main.tags,
    {
      Role  = var.vm_roles[count.index]
      Index = count.index
    }
  )
}
