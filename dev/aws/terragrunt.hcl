# terragrunt config for aws resources 

# generator function
generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite"
    contents = << EOF
    terraform {
        required_providers {
            aws = {
                source = "hashicorp/aws"
                version = "~>5.0"
            }
        }
        backend "s3" {}
    }


    provider "aws" {
        region = "${local.env_vars.region}"
    }

    EOF
}

remote_state {
    backend = "s3"
    config = {
        bucket = "qa-tf-state-01923343"
        key = "terraform.tfstate"
        dynamodb_table = "tf_state_locking"
        encrypt = true
        region = "us-west-2"
    }
}

locals {
    env_vars = yamldecode(file("environment_vars.yaml"))
}

# vpc/terragrunt.hcl
dependencu "whatever" {
    depends_on = "../vpc"
}
inputs = {
    vpc_whatever  = dependency.vpc.output.vpc_id
}

varibale "vpc_whateve" {
    description = ""
    type = string
}
# main.tf 

resource "what_i_will_import" "name" {}
terraform init -> import 

           