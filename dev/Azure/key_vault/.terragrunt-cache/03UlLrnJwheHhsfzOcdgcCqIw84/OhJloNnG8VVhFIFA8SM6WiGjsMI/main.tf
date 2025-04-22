data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "projectx" {
    name = "projectx"
}

module "dev-kv-1" {
    source = "../../modules/key_vault"
    name = var.name
    location = var.location
    resource_group_name = data.azurerm_resource_group.projectx.name
    enable_disk_for_encription = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days = 7
    purge_protection_enabled = false

    sku_name = "standard"

    access_policy {
        # defining access policy for identities user, managed_identity ..
        # id
        # permissions
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm.client_config.current.object_id
        key_permissions = [
            "GET",
            "SET"
        ]
        secret_permissions = [
            "GET",
        ]
    }

}