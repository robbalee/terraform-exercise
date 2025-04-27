/**
 * # AWS VPC Module
 * 
 * This module provisions an AWS Virtual Private Cloud (VPC) with configurable CIDR blocks.
 * It provides networking infrastructure for AWS resources with proper isolation and security.
 *
 * ## Features
 * - Creates a VPC with customizable CIDR block
 * - Supports tagging for resource organization and identification
 * - Configurable AWS region
 */

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

# Create a VPC with specified CIDR block and tags
resource "aws_vpc" "vpc_module" {
    cidr_block  = var.vpc_cidr
    tags        = var.tags
}
