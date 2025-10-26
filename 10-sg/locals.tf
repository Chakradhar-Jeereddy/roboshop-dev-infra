locals {
    common_tags = {
        project = var.project_name
        env = var.environment
    }
    common_name_suffix = "${var.project_name}-${var.environment}" #roboshop-dev
}