data "aws_ssm_parameter" "backend_alb" {
      name = "/${var.project_name}/${var.environment}/backend_alb"
}