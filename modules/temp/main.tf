terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ""
        }
        azurerm = {
            source = "hashicorp/azurerm"
            version = ""
        }
    }
    backend "s3" {
        bucket = ""
        key = ""
        encrypt = ""
        dynamodb_table = """
        region = ""
    }
}

provider "aws" {
    region = ""
}

provider "azurerm" {
    features {}
}

data "aws_vpc" "vpc_module" {
    filters {
        name = "my_filter"
        value = default 
    }
}

data "" "" {
    subnet_id = data.aws_vpc.vpc_module.id
}
 
locals {
    common_tags = {
        owner = """
        Environment = var.env
    }
}

# locals vs variables
# locals are defined under the scope of this file to substitute complex expressions 

terraform {
    # this block manages the config of terraform for this module / resource
    backend "azurerm" {
        resource_group = ""
        storage_account_name = "" 
        container = """
        key = "terraform.tfstate"
    }
     

}
resource "azure_virtual_network" "dev-euw1-fr-end-1" {
    name = ""
    count = ""
}
resource "azurerm_linux_virtual_machine" ""{

}

module "" {
    source = "../../module/vpc"
    tags = { # i am assuming this is a map
        tag1 = ""
        tag2 = "" 
    }
}

module "" {
    for_each = ["dev", "prod", "stag"]
    name = "${each.item}-${region}-web-server"
}

provider "azurerm" {
    features {}
}

backend "azirerm" {
    resource_group = resource_group.name
    stage_account_name = ""
    storage_container = """
    key = "" 
}

# run provisioner in a null resource
resource "null_resource" "provisioner" {
    provisioner "local-exec":
    command = "echo 'hello world'"
}

resource "azure_app_service" "dev-euw1-web-1"{
    count = 2 # this 
    name = """
    location = """  
    resource_group = ""
}

resource "azurerm_key_vault_secret" "dev-usw1-key-2"{
    key_vault_name = azurerm_key_vault.name

}

resource "azurerm_azureb2c" "dev-eue1-web-3" {
    for_each = var.key_vault # this is either list of maps or strings
    name = "b2c-${each.key}"
    location = "${each.value}"
}
