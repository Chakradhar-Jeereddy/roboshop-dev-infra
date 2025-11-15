# Use VPC module to create VPC, subnet
module "vpc" {
    # source = "../modules"
    source = "git::https://github.com/Chakradhar-Jeereddy/IaC.git//roboshop/modules"
    # Refer module from git repo
    # To download latest changes to module in git use "terraform init --upgrade"
    vpc_cidr = var.vpc_cidr
    project_name = var.project_name
    environment = var.environment
    public_cidrs = var.public_cidrs
    private_cidrs = var.private_cidrs
    database_cidrs = var.database_cidrs
    is_peering_required = false
}