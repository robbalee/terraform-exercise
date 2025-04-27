/**
 * # Azure Key Vault Deployment for Development Environment
 * 
 * This configuration provisions an Azure Key Vault in the development environment
 * using the reusable Key Vault module. It sets appropriate development-specific
 * settings such as a shorter soft-delete retention period and disabled purge protection.
 *
 * ## Features
 * - Creates a development-appropriate Key Vault with standard security settings
 * - Configures shorter retention period (7 days) for development purposes
 * - Uses Azure client configuration for access policies
 * - Disables purge protection to allow easier management in development
 */

# Get the current Azure client configuration for access policies
data "azurerm_client_config" "current" {}

# Create a Key Vault using the reusable module
module "dev-kv-1" {
    source = "../../../modules/key_vault"
    name = var.name                      # Key Vault name from variables
    location = var.location              # Azure region from variables
    resource_group = var.resource_group  # Resource group from variables
    soft_delete_retention_days = 7       # 7 days retention (shorter for dev environment)
    purge_protection_enabled = false     # Disabled for easier management in development
    tenant_id = var.tenant_id            # Tenant ID for the Key Vault

    # Access policies can be configured as needed
    # Uncomment and adjust the following block when needed:
    # access_policy  {
    #     # defining access policy for identities user, managed_identity ..
    #     tenant_id = var.tenant_id
    #     object_id = data.azurerm_client_config.current.object_id
    #     key_permissions = [
    #         "GET",
    #         "SET",
    #     ]
    #     secret_permissions = [
    #         "GET",
    #     ]
    # }
}