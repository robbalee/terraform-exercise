terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}
provider "azurerm" {
    features {}
}

data "azurerm_resource_group" "example" {
    name = var.rg_name
}

data "azurerm_storage_account" "mystoraget" {
    name               = var.storage_account_name
    resource_group_name = data.azurerm_resource_group.example.name
}

resource "azurerm_storage_container" "tfstate" {
    name = "tfstate"
    storage_account_name = data.azurerm_storage_account.mystoraget.name
    container_access_type = "private"
    metadata = {
        environment = "development"
        version     = "v1.0"
    }
}

# remove the local file and use the backend the /dev environment in terragrunt.hcl file