variable "rg_name" {
    type = string
    default = "example-rg"
}
variable "rg_location" {
    type = string
    default = "East US"
}

variable "tags" {
    type = map(string)
    default = {
        environment = "dev"
        project = "basics"
    }
}