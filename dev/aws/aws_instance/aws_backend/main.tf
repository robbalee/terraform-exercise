terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.0"
        }
    }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "qa-tf-state-01923343"
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "tf_state_locking"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"
    
    attribute {
        name = "LockID"
        type = "S"
    }
}

