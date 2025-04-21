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
    access_key = var.aws_access_key # not a good practice
    secret_key = var.aws_secret_key # just a placeholder
}
backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "vpc/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
}

module "eu_vpc" {
    module = "./modules/VPC"
    Name = "eu-vpc"
    aws_region = "eu-west-1"
    vpc_cidr = "10.0.0.0/16"
    tags = {
        Name = "eu-vpc"
        Environment = "dev"
    }
}
# so this create a VPC in the dev environment in the eu-west-1 region
# later change the config for this VPC using terragrunt