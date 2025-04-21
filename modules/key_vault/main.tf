data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "dev-kv-1" {
    name = var.name
    location = var.location
    resource_group_name = var.resource_group
    enable_disk_for_encription = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days = var.soft_delete_retention_days
    purge_protection_enabled = var.purge_protection_enabled

    sku_name = "standard"

    dynamic "access_policy" {
        for_each = var.access_policy
        content = {
            tenant_id = each.value.tenant_id
            object_id = each.value.object_id
            key_permissions = each.value.key_permissions
            secret_permissions = each.value.secret_permissions
        }
    }

}