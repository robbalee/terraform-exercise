terraform {
    source = "./"
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
    name = local.env_vars.servername
}
