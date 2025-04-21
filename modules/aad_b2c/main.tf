resource "azurerm_aadb2c_directory" "api" {
  name                = "aadb2c-${var.name}"
  location            = var.location
  display_name = "${var.name}-b2c-tenant"
  domain_name = "${var.name}.onmicrosoft.com"
  sku_name            = var.sku
  resource_group = var.rg_name 
}


