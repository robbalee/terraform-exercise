/**
 * # Azure AD B2C Module
 * 
 * This module creates an Azure Active Directory B2C tenant for customer identity
 * and access management. It provides a scalable and secure platform for managing
 * customer identities and controlling access to applications.
 *
 * ## Features
 * - Creates an Azure AD B2C directory with custom domain name
 * - Configurable SKU (pricing tier)
 * - Integration with other Azure resources
 * - Customizable display name
 */

# Create an Azure AD B2C directory
resource "azurerm_aadb2c_directory" "api" {
#   name                = "aadb2c-${var.name}"
  display_name        = "${var.name}-b2c-tenant"
  domain_name         = "${var.name}.onmicrosoft.com"
  sku_name            = var.sku
  resource_group_name      = var.rg_name
  data_residency_location  = var.data_residency_location
}
