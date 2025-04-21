terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "4.0"
        }
    }
}
provider "aws" {
    region = var.aws_region
}

backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "vpc/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks". 
    encrypt        = true
}

resource "aws_vpc" "vpc_module" {
    cidr_block  = var.vpc_cidr
    name        = var.vpc_name
    tags        = {
        Name = var.vpc.name
        Environment = var.environment
    }
}

terraform {
    required_providers {}
    backend "azurerm_storage" {
        account:
        key: 
        cosmosDB_table:
    }
}
provider "azurerm" {
    features{}
    subscription:
    access_token:
    bearer_token:
}

resource "azurerm_resource_group" "my_group" {
    name = var.name
    location = var.location
    for each = var.item
    content = {
        content1 = my_group.value1
        content2 = my_group.value2
    }
}
