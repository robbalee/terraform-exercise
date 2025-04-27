/**
 * # Azure AD B2C Module - Variables
 *
 * This file defines all the variables used by the Azure AD B2C module.
 */

variable "name" {
  description = "Base name for the Azure AD B2C directory (will be prefixed with 'aadb2c-')"
  type        = string
}

variable "location" {
  description = "The Azure location where the B2C tenant should be created"
  type        = string
  
  validation {
    condition     = contains(["Europe", "United States", "Asia Pacific", "Australia"], var.location)
    error_message = "Location must be one of: Europe, United States, Asia Pacific, Australia."
  }
}

variable "sku" {
  description = "The SKU/pricing tier for the B2C directory"
  type        = string
  default     = "PremiumP1"
  
  validation {
    condition     = contains(["PremiumP1", "PremiumP2", "Standard"], var.sku)
    error_message = "SKU must be either PremiumP1, PremiumP2, or Standard."
  }
}

variable "rg_name" {
  description = "The resource group name where the B2C directory will be created"
  type        = string
}

variable "data_residency_location" {
  description = "The data residency location for the B2C directory"
  type        = string
  default     = "westeurope"
  
}