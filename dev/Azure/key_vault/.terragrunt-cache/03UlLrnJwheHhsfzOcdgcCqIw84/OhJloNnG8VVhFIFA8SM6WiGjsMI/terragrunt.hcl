include {
    path = find_in_parent_folders()
}
terraform {
    source = "../../../modules/key_vault"
}

# dependency "resource_group" {
#     config_path = "../resource_group"
# }

locals {
    kv_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

inputs = {
    name = "example-kv"
    location = "Europe"
    resource_group_name = "LTIMINDTREE"
    enable_disk_for_encription = true
    tenant_id = "f6355a9e-f9b1-49c1-a932-943f62d80678"
    # soft_delete_retention_days = 7
    purge_protection_enabled = false

    sku_name = "standard"

    access_policy = {
        tenant_id = "f6355a9e-f9b1-49c1-a932-943f62d80678"
        object_id = "7e7d511f-599b-4bb7-9ab1-e683796f7c13"
        key_permissions = [
            "GET",
            "SET"
        ]
        secret_permissions = [
            "GET",
        ]
    }
}