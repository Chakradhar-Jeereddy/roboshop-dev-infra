data "aws_ami" "ami" {
  owners        = ["973714476881"]
  most_recent  = true
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ssm_parameter" "bastion_sg_id" {
      name = "/${var.project_name}/${var.environment}/bastion_sg_id.value"
}