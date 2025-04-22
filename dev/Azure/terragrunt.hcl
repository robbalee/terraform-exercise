locals {
    env_vars = yamldecode(file("environment_vars.yaml"))
}

generate "provider" {
    path = "provider.tf"
    contents = <<EOF
    terraform {
        reqiuired_providers {
            azurerm = {
                source = "hashicorp/azurerm"
                version = "~> 3.0"
            }
        }
        backend "azurerm" {}

    }
    provider "azurerm" {
        features {}
        subscription_id = "${local.env_vars.subscription}"
        tenant_id = "${local.env_vars.tenant_id}"
    }
    EOF
}

remote_state {
    resource_group_name = local.env_vars.state_resource_group
    storage_account_name = local.env_vars.state_storage_account
    container_name = local.env_vars.state_container
    key = "${path_relative_to_include()}/terraform.tfstate"
    
    generate = {
        path = "backend.tf"
        if_exists = "overwrite"
    }
}

inputs = {
    location = local.env_vars.location
    environment = local.env_vars.environment
}



# this is the bare config that is copied to each environment
