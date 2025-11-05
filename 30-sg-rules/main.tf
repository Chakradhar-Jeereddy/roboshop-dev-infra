# Frontend accepting traffic from frontend ALB
resource "aws_security_group_rule" "alb_to_frontend"{
  type = "ingress"
  security_group_id = module.sg[9].sg_id # frontend security group
  source_security_group_id = module.sg[11].sg_id # ALB security group
  from_port = 80
  protocol = "tcp"
  to_port = 80
}