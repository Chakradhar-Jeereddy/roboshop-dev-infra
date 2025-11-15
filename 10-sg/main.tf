# Using open source module
/* module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.common_name_suffix}-catalogue"
  use_name_prefix = false
  description = "Security group for catalogue with custom ports open within VPC, egress all trafic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
} */

# Create security group using the module custom-sg for each component
module "sg" {
  count = length(var.sg_name)
  source = "git::https://github.com/Chakradhar-Jeereddy/roboshop-dev-infra.git//custom-sg"
  project_name = var.project_name
  environment = var.environment
  sg_name = var.sg_name[count.index]
  sg_description = var.sg_description
  vpc_id = data.aws_ssm_parameter.vpc_id.value
}

