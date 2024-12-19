# provider config

terraform {
  backend "azurerm" {
    resource_group_name  = var.rg_name
    storage_account_name = var.storage_account_name
    container_name      = var.container_name
    key                 = var.key
  }
}

module "resource_group" {
  source   = "../resource-group"
  name     = var.rg_name
  location = var.rg_location
  tags     = var.tags
}



