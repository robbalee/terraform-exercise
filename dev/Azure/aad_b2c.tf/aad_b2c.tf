/** * # Azure AD B2C Tenant Deployment for Project X *  * This configuration deploys an Azure Active Directory B2C tenant for Project X * using the reusable AAD B2C module. It sets up a premium B2C instance in Europe * with custom domain and display name for identity management. * * ## Features * - Creates a PremiumP2 tier B2C tenant for advanced identity features * - Configures custom domain for consistent branding * - Deploys in European region for compliance * - Uses existing project resource group */# Configure Azure provider requirementsterraform {    required_providers {        azurerm = {            source = "hashicorp/azurerm"            version = "~>5.0"  # Latest Azure provider version        }    }}# Azure provider configurationprovider "azurerm" {    features = {}  # Required empty features block}

# Reference existing project resource group
data "azurerm_resource_group" "projectx" {
    name = "projectx"  # Specific resource group for Project X
}

# Deploy Azure AD B2C tenant using the reusable module
module "aad_b2c" {
    source = "../../modules/aad_b2c"  # Reference to reusable module
    
    # B2C configuration
    name = "aad-b2c-euw1-1"  # Name with region indicator (Europe West 1)
    location = "Europe"      # European region for data residency compliance
    display_name = "projectx-b2c-tenant"  # User-friendly display name
    domain_name = "projectx.onmicrosoft.com"  # Domain for authentication endpoints
    sku_name = "PremiumP2"   # Premium tier for advanced features and scale
    resource_group = data.azurerm_resource_group.projectx.name  # Use existing resource group
}