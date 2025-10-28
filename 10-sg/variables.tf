variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "sg_name" {
    default = ["mongodb","redis","mysql","rabitmq"]
}

variable "sg_description" {
    default = "Created for mongodb"
}

