terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.0"
        }
    }
    backend "s3" {
        bucket = "qa-tf-state-01923343"
        key = "terraform.tfstate"
        dynamodb_table = "tf_state_locking"
        encrypt = true
        region = "us-west-2"
    }
}


provider "aws" {
    region = "us-west-2"
}
