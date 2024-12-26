# provider config

terraform {
  backend "azurerm" {
    resource_group_name  = var.rg_name
  }
}

module "resource_group" {
  source   = "../modules/resource-group"
  name     = var.rg_name
  location = var.rg_location
  tags     = var.tags
}



