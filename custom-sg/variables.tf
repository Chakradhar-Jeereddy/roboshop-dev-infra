variable "sg_name" {
    type = string
}

variable "sg_description" {
    type = string
}

variable "sg_tags" {
    type = map
    default = {}
}

variable "project_name" {
    type = string
}

variable "environment" {
    type = string
}