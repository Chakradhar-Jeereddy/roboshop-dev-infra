module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.common_name_suffix}-catalogue"
  description = "Security group for catalogue with custom ports open within VPC, egress all trafic"
  vpc_id      = "vpc-12345678"

 
}