/**
 * # Azure Key Vault Module
 * 
 * This module creates an Azure Key Vault for securely storing and accessing secrets,
 * keys, and certificates. The Key Vault provides a centralized solution for storing
 * sensitive information with controlled access.
 *
 * ## Features
 * - Provisions an Azure Key Vault with standard SKU
 * - Configurable soft-delete retention period
 * - Optional purge protection
 * - Integration with Azure AD for access policies
 * - Support for storing secrets, keys, and certificates
 */

# Get current Azure client configuration (for tenant ID, etc.)
data "azurerm_client_config" "current" {}

# Create Azure Key Vault with specified configuration
resource "azurerm_key_vault" "dev-kv-1" {
    name                        = var.name
    location                    = var.location
    resource_group_name         = var.resource_group
    tenant_id                   = var.tenant_id
    soft_delete_retention_days  = var.soft_delete_retention_days
    purge_protection_enabled    = var.purge_protection_enabled
    sku_name                    = "standard"

    # Access policies to be configured separately via the access_policy block
    # or through the azurerm_key_vault_access_policy resource
}
