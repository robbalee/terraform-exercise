terraform {
    source = "https://github.com/robbalee/terraform-exercise.git//modules/VPC?ref=7ead325172c4196d99071e5b40b38284250979c7"
}   
locals {
    env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml"))
}

include {
    path = find_in_parent_folder()
}

dependency {

}

inputs = {
    cidr_block = local.env_vars.vpc_cidr
    tags = {
        Environment = local.env_vars.environment
    }
}
