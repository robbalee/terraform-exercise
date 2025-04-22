data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "dev-kv-1" {
    name = var.name
    location = var.location
    resource_group_name = var.resource_group
    # Removed invalid attribute enable_disk_for_encription
    tenant_id = var.tenant_id
    soft_delete_retention_days = var.soft_delete_retention_days
    purge_protection_enabled = var.purge_protection_enabled

    sku_name = "standard"

    # access_policy = {
    #     tenant_id = var.access_policy.tenant_id
    #     object_id = var.access_policy.object_id
    #     key_permissions = var.access_policy.key_permissions
    #     secret_permissions = var.access_policy.secret_permissions
    # }
}