/**
 * # Azure Resource Group Module
 * 
 * This module creates an Azure Resource Group, which is a logical container for
 * resources deployed within an Azure subscription.
 *
 * ## Features
 * - Creates a single Azure resource group
 * - Supports custom naming
 * - Allows specification of Azure region/location
 * - Supports tagging for resource organization
 */

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
