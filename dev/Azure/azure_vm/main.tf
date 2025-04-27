/** * # Azure VM Deployment for Development Environment *  * This configuration provisions an Azure Virtual Machine along with necessary networking * infrastructure like virtual network and subnet. It uses the Azure backend for state * management to enable team collaboration and state persistence. * * ## Features * - Creates a dedicated resource group for VM resources * - Configures virtual network with multiple address spaces * - Provisions Linux VM with configurable size * - Uses remote state management with Azure Storage */# Azure Resource Manager provider configurationterraform {    required_providers {        azurerm = {            source = "hashicorp/azurerm"            version = "2.0.0"        }    }        # Azure backend configuration for state management    backend "azurerm" {        resource_group_name = var.rg_name        storage_account_name = var.storage_account_name        container_name = var.container_name        key = "azurerm_vm/terraform.tfstate"    }}provider "azurerm" {    features {}  # Required empty features block}# Resource group for VM resources# Only name and location are required for a basic resource groupresource "azurerm_resource_group" "my_rg" {    name = var.name    location = var.location}

# Linux VM configuration with variable-based sizing
resource "azure_linux_virtual_machine" "my_vm" {
    name = var.vm_name
    resource_group_name = azurerm_resource_group.my_rg.name  # Reference to created resource group
    size = var.vm_size  # VM size from variables (e.g., Standard_B1s)
    admin = var.admin   # Admin credentials from variables
}

# Virtual network with flexible configuration
resource "azurerm_virtual_network" "my_vnet" {
    resource_group_name = azurerm_resource_group.my_rg.name  # Reference to created resource group
    # Conditional name assignment with default fallback
    name = var.vnet_name != "" ? var.vnet_name : "default_vnet"
    
    # Multiple address spaces for network segmentation:
    # - 10.0.0.0/16: Provides 65,536 addresses for main resources
    # - 192.72.0.0/28: Small subnet with 16 addresses for specialized resources
    address_space = ["10.0.0.0/16", "192.72.0.0/28"]
    
    location = azurerm_resource_group.my_rg.location  # Use same region as resource group
}


