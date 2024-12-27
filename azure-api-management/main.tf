resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
  
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}

resource "random_string" "azurerm_api_management_name" {
  length  = 13
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_api_management" "api" {
  name                = "apiservice${random_string.azurerm_api_management_name.result}"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
  publisher_email     = var.publisher_email
  publisher_name      = var.publisher_name
  sku_name            = "${var.sku}_${var.sku_count}"
}

data "azurerm_api_management" "api2" {
  name                = azurerm_api_management.api.name
  resource_group_name = azurerm_resource_group.rg.name
}

output "api_management_name" {
  value = data.azurerm_api_management.api2.name
}

module "api_management2" {
  source = "./api_management" # what is source? answer
  api_management_name = data.azurerm_api_management.api2.name
  resource_group_name = azurerm_resource_group.rg.name 
}

output "api_management_name" {
  value = module.api_management2.api_management_name
}
# Path: azure-api-management/variables.tf