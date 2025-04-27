/**
 * # AWS VPC Module - Variables
 *
 * This file defines all the variables used by the AWS VPC module.
 */

variable "aws_region" {
  description = "The AWS region in which to deploy the VPC"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "VPC CIDR block must be a valid CIDR notation."
  }
}

variable "tags" {
  description = "A map of tags to assign to the VPC resources"
  type        = map(string)
  default     = {}
}
