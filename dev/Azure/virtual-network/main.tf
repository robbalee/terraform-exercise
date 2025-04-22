# Add this provider block at the top of your file
provider "azurerm" {
  features {}  # Empty features block is required
}

# First, let's create a resource group to contain our network
resource "azurerm_resource_group" "example" {
  name     = "example-network-rg"
  location = "West Europe"  # or your preferred region
}

# Create the virtual network with a CIDR block of 10.0.0.0/16
resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]  # This gives you 65,536 addresses

  tags = {
    environment = "dev"
    project     = "network-example"
  }
}

# Create the subnet as a separate resource
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]  # This gives you 256 addresses
}
