terraform {
    required_providers = {
        source = "hashicorp"
        version = "5.0"
    }
}

provider "aws" {
    region = "us-west-1"
}

resource "s3" "state_bucket" {
    bucket = ""
    key = ""
    versioning = yes
    encript = yes
}
resource "dynamodb_table" "state_lock_table" {
    name = ""
    hash_key = ""
}