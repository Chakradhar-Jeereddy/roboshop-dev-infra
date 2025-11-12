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
resource "aws_security_group_rule" "backend_alb_frontend" {
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

#Rule for bastion accepting laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  security_group_id = local.bastion_sg_id
  cidr_blocks = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#Rule for mangodb accepting bastion
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#Rule for redis accepting bastion
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#Rule for rabitmq accepting bastion
resource "aws_security_group_rule" "rabitmq_bastion" {
  type              = "ingress"
  security_group_id = local.rabitmq_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}

#Rule for mysql accepting bastion
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}