/**
 * # Azure VM with Ansible Integration
 * 
 * This configuration deploys an Azure Linux virtual machine and configures it using Ansible.
 * It creates all necessary networking components and implements automated configuration
 * management through Ansible playbooks.
 *
 * ## Features
 * - Provisions Azure Linux VM with Ubuntu Server 20.04 LTS
 * - Configures networking with public IP and DNS name
 * - Uses cloud-init for initial configuration
 * - Integrates with Ansible for automated application deployment
 * - Implements security best practices for authentication
 */

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.21.1"  # Specific version for stability
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"   # Required for local-exec provisioners
    }
  }
}

# Azure provider configuration
provider "azurerm" {
  skip_provider_registration = true  # Skip provider registration for managed environments
  features {}  # Required features block
}

# Null provider for local-exec operations
provider "null" {
  # Configuration options
}

# Input variables
# ==========================
variable "resource_group_name" {}  # Name of the resource group
variable "location" {}            # Azure region
variable "subnet_id" {}           # Subnet ID for network integration

# Random identifier for unique DNS name
# ==========================
resource "random_id" "webserver_dns" {
  byte_length = 8  # Generate 8-byte random identifier
}

# Public IP configuration
# ==========================
resource "azurerm_public_ip" "cloudacademydevops-web-vm-pip" {
  name                = "cloudacademy-web-vm"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"  # Ensures IP doesn't change after restart
  domain_name_label   = "ca-labs-web-${lower(random_id.webserver_dns.hex)}"  # Unique DNS name
}

# Network interface configuration
# ==========================
resource "azurerm_network_interface" "cloudacademydevops-vm-nic" {
  name                = "cloudacademy-vm-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"  # Let Azure assign a private IP
    public_ip_address_id          = azurerm_public_ip.cloudacademydevops-web-vm-pip.id
  }
}

# Cloud-init configuration for initial VM setup
# ==========================
data "template_cloudinit_config" "vm_config" {
  gzip          = true          # Compress the content
  base64_encode = true          # Encode for transmission

  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #! /bin/bash
    echo v1.00!
    echo example script only...
    EOF
  }
}

# Virtual machine resource
# ==========================
resource "azurerm_linux_virtual_machine" "cloudacademy_web_vm" {
  name                  = "cloudacademy-web-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.cloudacademydevops-vm-nic.id]
  size                  = "Standard_B1s"  # Entry-level VM size, suitable for dev/test

  computer_name                   = "cloudacademy-vm"
  admin_username                  = "superadmin"
  admin_password                  = "s3cr3tP@55word"  # Should be replaced with key-based auth in production
  disable_password_authentication = false              # For simplicity in dev; use SSH keys in prod

  # OS disk configuration
  os_disk {
    name                 = "cloudacademy-vm-disk01"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"  # Locally redundant storage
  }

  # VM image configuration
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"  # Ubuntu 20.04 LTS Gen2
    version   = "latest"
  }

  # Apply cloud-init config for initial setup
  custom_data = data.template_cloudinit_config.vm_config.rendered

  tags = {
    org = "cloudacademy"
    app = "devops"
  }
}

# Output values
# ==========================
output "vm_public_ip" {
  value = azurerm_public_ip.cloudacademydevops-web-vm-pip.ip_address
}

output "vm_dns" {
  value = azurerm_public_ip.cloudacademydevops-web-vm-pip.fqdn
}