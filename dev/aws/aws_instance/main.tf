/**
 * # AWS EC2 Instance Deployment for Development Environment
 * 
 * This configuration provisions an Amazon EC2 instance using the latest Amazon Linux 2023
 * AMI with appropriate storage configuration. It's designed for development workloads
 * with a focus on standardized deployment and secure storage.
 *
 * ## Features
 * - Dynamically selects the latest Amazon Linux 2023 AMI
 * - Configures instance with custom size EBS volume
 * - Implements proper tagging for resource management
 * - Configures secure storage with encryption
 */

# Retrieve the latest Amazon Linux 2023 AMI from AWS Marketplace
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]  # Amazon-owned AMIs

  filter {
    name   = "name"
    values = ["al2023-ami-*-kernel-6.1-*"]  # Amazon Linux 2023 with 6.1 kernel
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]  # Hardware Virtual Machine (recommended virtualization type)
  }
}

# Create an EC2 instance with the retrieved AMI
resource "aws_instance" "ec2_instance" {
    
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type  # Instance size defined in variables
    tags = {
        Name = var.name  # Instance name from variables
    }
    
    # Attach an EBS volume for persistent storage
    ebs_block_device {
        device_name = "/dev/sda1"  # Primary device
        volume_size = 10           # 10GB storage volume
        volume_type = "gp2"        # General Purpose SSD (balanced performance/cost)
        delete_on_termination = true  # Remove volume when instance is terminated
    }  
}

# Additional configuration for backend state storage
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.0"
        }
    }
    backend "s3" {
        bucket = "qa-tf-state-0333"
        key = "ec2/terraform.tfstate"
        region = "us-west-2"
        dynamodb_table = "tf_state_locking"
        encrypt = true
    }
}

# AWS provider configuration
provider "aws" {
    region = "us-west-2"  # US West (Oregon) region
}

# Alternative AMI data source with similar configuration
data "aws_ami" "ami" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["al2023-ami-*-kernel-6.1-*"]  # Amazon Linux 2023
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
} 

# Second EC2 instance with enhanced configuration
resource "aws_instance" "my_ec2" {
    ami = data.aws_ami.ami.id
    instance_type = var.instance_type

    # Encrypted EBS volume configuration
    ebs_block_device {
        device_name = "/dev/sda1"
        volume_size = 10
        volume_type = "gp2"
        encrypted = true  # Data-at-rest encryption enabled
    }

    # Root volume configuration
    root_block_device {
        volume_size = 20            # 20GB root volume
        volume_type = "gp3"         # Latest generation GP SSD
        delete_on_termination = true
    }

    tags = {
        Name = var.name
    }
}