# Using open source module
/* module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.common_name_suffix}-catalogue"
  use_name_prefix = false
  description = "Security group for catalogue with custom ports open within VPC, egress all trafic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
} */

module "sg" {
  count = length(var.sg_name)
  source = "git::https://github.com/Chakradhar-Jeereddy/roboshop-dev-infra.git//custom-sg"
  project_name = var.project_name
  environment = var.environment
  sg_name = var.sg_name[count.index]
  sg_description = var.sg_description
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}

# Frontend accepting traffic from frontend ALB
resource "aws_security_group_rule" "alb_to_frontend" {
  security_group_id = module.sg[9].sg_id # frontend security group
  source_security_group_id = module.sg[11].sg_id # ALB security group
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}