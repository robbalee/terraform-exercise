output "rg_name" {
  description = "The name of the resource group"
  value       = data.azurerm_resource_group.example.name
}