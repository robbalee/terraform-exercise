variable "location" {
    description = "key vault location"
    type  = "string"
}
variable "name" {
    description = "key vault name"
    type  = "string"
}
variable "resource_group" {
    description = "key vault resource_group"
    type  = "string"
}

variable "access_policy" {
    description = "access policy for key valut"
    type = object({
        tenant_id = int
        object_id = int
        key_permissions = list(string)
        secret_permissions = list(string) 
    })

    default = []
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft-deleted Key Vaults"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Enable purge protection for the Key Vault"
  type        = bool
  default     = false
}