#Rule for frontend accepting frontend alb
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  security_group_id = local.frontend_sg_id
  source_security_group_id = local.frontend_alb_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

#Rule for backend alb accepting frontend
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id = local.frontend_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}

#Rule for backend alb accepting bastion
resource "aws_security_group_rule" "backend_alb_bastion" {
  type              = "ingress"
  security_group_id = local.backend_alb_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}