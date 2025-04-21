variable "aws_region" {
    description = "the aws region to deploy the resources"
    type = string
    default = "eu-west-1"
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/24"
}
variable "vpc_name" {
    description = "Name of the VPC"
    type        = string
    default     = "my-vpc"
}

variable "environment" {
    description = "The environment for the VPC"
    type        = string
    default     = "dev"
}

variable "tags" {
    description = "tags for this resource"
    type = map(string)
    default = {
      "Name" = ""
      "Environment" = ""
    }
}