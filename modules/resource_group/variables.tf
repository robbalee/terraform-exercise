/**
 * # Resource Group Module - Variables
 *
 * This file defines all the variables used by the Azure Resource Group module.
 */

variable "name" {
  description = "The name of the resource group"
  type        = string

  validation {
    condition     = length(var.name) > 1 && length(var.name) <= 80
    error_message = "Resource group name must be between 1 and 80 characters."
  }
}

variable "location" {
  description = "The Azure location/region where the resource group should be created"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource group"
  type        = map(string)
  default     = {}
}
