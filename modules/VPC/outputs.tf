output "vpc_id" {
    descriptiopn = "The ID of the VPC"
    value = aws_vpc.vpc_module.id
}

output "vnet_name" {
    description = "this is the output from the vnet deployment in ${azurerm_virtual_network.my_vnet.id}"
    value = ${azurerm_virtual_network.my_vnet.id}
}
output "whatever" {
    # just refer to any value from the deployments
}