terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>3.0"
        }
    }
}

# provider "azurerm" {
#     features {
#         # Add any required features here
#         # For example, if you need to enable the Key Vault provider:
#         key_vault {
#             purge_soft_delete_on_destroy = true
#             recover_soft_deleted_key_vaults = true
#         }
#     }
# }
