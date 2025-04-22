# [ x ]
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>5.0"
        }
    }
}

provider "azurerm" {
    features = {}
}

data "azurerm_resource_group" "projectx"{
    name = "projectx"
}


module "aad_b2c" {
    source = "../../modules/aad_b2c"
    name = "aad-b2c-euw1-1"
    location = "Europe"
    display_name = "projectx-b2c-tenant"
    domain_name = "projectx.onmicrosoft.com"
    sku_name = "PremiumP2"
    resource_group = data.azurerm_resource_group.projectx.name
}