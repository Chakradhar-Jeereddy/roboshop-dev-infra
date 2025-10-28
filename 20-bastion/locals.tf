locals {
    ami_id = data.aws_ami.ami.id
    bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id
    common_tags = {
        Project = var.project_name
        Environment = var.environment
        Terraform = true
    }
}
