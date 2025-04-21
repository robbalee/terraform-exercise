terraform {
    backend "" {
        organization = """
        workspaces = {
            name = ""
        }
    }
    required_providers = {
        source = ""
        version = ""
    }
}

provider "aws" {
    region = ""
}
