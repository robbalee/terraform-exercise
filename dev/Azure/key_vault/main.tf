data "azurerm_client_config" "current" {}

module "dev-kv-1" {
    source = "../../../modules/key_vault"
    name = var.name
    location = var.location
    resource_group = var.resource_group
    soft_delete_retention_days = 7
    purge_protection_enabled = false


    # access_policy  {
    #     # defining access policy for identities user, managed_identity ..
    #     # id
    #     # permissions
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