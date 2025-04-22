# list of azure providers for azure vm, vnet, resource group
# azurerm_resource_group, azurerm_virtual_network, azurerm_subnet, azurerm_public_ip, azurerm_virtual_machine
# azure resource group -> azure vnet -> azure linux virtual machine -> azure subnet 
terraform {
    required_providers {
        azurerm = {
            source =- "hashicorp/azurerm"
            version = "2.0.0"
        }
    }
    backend "azurerm" {
        resource_group_name = var.rg_name
        storage_account_name = var.storage_account_name
        container_name = var.container_name
        key = "azurerm_vm/terraform.tfstate"
    }
}
provider "azurerm" {
    features {}
}
# name and location is enough
resource "azurerm_resource_group" "my_rg" {
    name = var.name
    location = var.location
}

resource "azure_linux_virtual_machine" "my_vm" {
    name = var.vm_name
    resource_group_name = azurerm_resource_group.my_rg.name
    size = var.vm_size
    admin = var.admin
}

resource "azurerm_virtual_network" "my_vnet" {
    resource_group = azurerm_resource_group.my_rg.name
    var.vnet_name != '' ? name = var.vnet_name, name = "default_vnet"
    address_space = ["10.0.0.0/16", "192.72.0.0/28"]
    location = azurerm_resource_group.my_rg.location
}


