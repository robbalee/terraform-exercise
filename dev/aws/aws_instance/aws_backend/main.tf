/**
 * # AWS Backend Infrastructure for Terraform State Management
 * 
 * This configuration creates the necessary AWS infrastructure for storing and managing 
 * Terraform state files remotely. It provisions an S3 bucket for state storage and a
 * DynamoDB table for state locking to prevent concurrent modifications.
 *
 * ## Features
 * - Creates a dedicated S3 bucket for Terraform state files
 * - Provisions a DynamoDB table for state locking and consistency
 * - Uses serverless pay-per-request billing for cost efficiency
 * - Enables secure remote state management for team collaboration
 */

# Required provider configuration
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.0"  # Use AWS provider version 5.x
        }
    }
}

# AWS provider configuration
provider "aws" {
    region = "us-west-2"  # US West (Oregon) region
}

# S3 bucket for storing Terraform state files
resource "aws_s3_bucket" "terraform_state" {
    bucket = "qa-tf-state-01923343"  # Globally unique bucket name
    
    # Note: In production, you would typically add the following:
    # - Versioning
    # - Encryption
    # - Lifecycle policies
    # - Access logging
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
    name = "tf_state_locking"  # Table name
    hash_key = "LockID"        # Required key name for Terraform
    billing_mode = "PAY_PER_REQUEST"  # Serverless billing, pay only for what you use
    
    # LockID attribute definition (required for Terraform)
    attribute {
        name = "LockID"
        type = "S"  # String type
    }
}

