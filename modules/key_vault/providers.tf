terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>5.0"
        }
    }
}

provider "azurerm" {
    features = {
        recover_soft_deleted_key_vaults = true
    }
}
