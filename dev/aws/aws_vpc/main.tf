/**
 * # AWS VPC Deployment for Development Environment
 * 
 * This configuration deploys an AWS VPC in the development environment using the 
 * reusable VPC module. It configures remote state management via S3 with DynamoDB
 * locking to enable team collaboration and state persistence.
 *
 * ## Features
 * - Deploys a VPC in the eu-west-1 region
 * - Uses remote state stored in S3 bucket with encryption
 * - Implements state locking via DynamoDB
 * - Configures appropriate environment tagging
 */

terraform {
  backend "s3" {
        bucket         = "terraform-state-bucket"
        key            = "vpc/terraform.tfstate"
        region         = "eu-west-1"
        dynamodb_table = "terraform-locks"
        encrypt        = true
    }
}

# Deploy a VPC in the EU (Ireland) region using the reusable VPC module
module "eu_vpc" {
    source = "../../../modules/VPC" # Reference to the reusable VPC module
    aws_region = "eu-west-1"        # EU (Ireland) region
    vpc_cidr = "10.0.0.0/16"        # Class A private network with 65,536 IP addresses
    tags = {
        Name = "eu-vpc"             # Identifier for the VPC
        Environment = "dev"         # Environment tag for resource categorization
    }
}

# Note: This configuration creates a VPC in the dev environment in the eu-west-1 region
# The configuration can be enhanced later with Terragrunt for better environment management