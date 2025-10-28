variable "project_name" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "sg_name" {
    default = [
        #databases
        "mongodb","redis","mysql","rabitmq",
        #backend
        "catalogue","user","cart","shipping","payment",
        #frontend
        "frontend",
        #bastion
        "bastion"
    ]
}

variable "sg_description" {
    default = "Created for mongodb"
}

