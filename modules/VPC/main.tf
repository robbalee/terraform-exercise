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

resource "aws_vpc" "vpc_module" {
    cidr_block  = var.vpc_cidr
    tags        = var.tags
}
