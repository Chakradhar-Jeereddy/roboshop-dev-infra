locals {
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = true
    }
    common_name_suffix = "${local.common_tags}-${var.sg_name}
}