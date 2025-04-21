variable "aws_region" {
    descroiption = "the aws region to deploy the resources"
    type = string
    default = "eu-west-1"
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/24
}
variable "vpc_name" {
    description = "Name of the VPC"
    type        = string
    default     = "my-vpc"
}
variable "environment" {
    description = "The environment for the VPC"
    type        = string
    default     = "dev"
}


variable "aws_region" {
    description = ""
    default = """
    type = string
}
variable "names" {
    type = map(string)
    default = {
        name1 = "kitari"
        name2 = "kitama"
    }
}
variable "list_of_names" {
    description = "list of resource names"
    type = list(string)
    default = [
        "name1", "name2"
    ]
}

variable "list_of_maps" {
    type = list(map(string))
    default = [{
        name1 = "kimosho"
        name2 = "lutobo"
    },
    {
        name3 = "bikana"
    }]
}

varibale "my_object" {
    description = "a simple terraform object"
    type = object({
        name =  string
        age = int
    })
    default = {
        name = "R"
        age = 12 
    }
}

variable "list_of_objects" {
    description = "this is a list of objects"
    type = list(objects({
        name = string
        age = 12
    }))
    defaults = [{
        name = "Mathew"
        age = 34
    },
    {
        name = "Matheus"
        age = 31
    }]
}
variable "tenants" {
    description = "tenants of our project"
    type = map(string)
    default = {
        name = "abebe"
        height = 185
    }
}


