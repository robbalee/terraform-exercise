terraform {
  backend "s3" {
        bucket         = "terraform-state-bucket"
        key            = "vpc/terraform.tfstate"
        region         = "eu-west-1"
        dynamodb_table = "terraform-locks"
        encrypt        = true
    }
}

module "eu_vpc" {
    source = "../../../modules/VPC" # change this ref
    aws_region = "eu-west-1"
    vpc_cidr = "10.0.0.0/16"
    tags = {
        Name = "eu-vpc"
        Environment = "dev"
    }
}
# so this create a VPC in the dev environment in the eu-west-1 region
# later change the config for this VPC using terragrunt