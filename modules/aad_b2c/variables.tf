variable "name" {
    description = "name for the AAD b2c tenant / directory"
    type = string
    default = "aad-b2c" # add random string 
}
variable "display_name" {
    description = "display name for the AAD b2c tenant / directory"
    type = string
    default = "aad-b2c" # add random string 
}

variable "location" {
    description = "Where does the data reside in azure regions"
    type = string
}

variable "sku" {
    description = "sku for AAD B2C tenant / directory"
    type = string
    default = "Premiump1"
}

variable "rg_name" {
    description = "resource group name"
    type = string
}
