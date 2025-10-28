resource "aws_ssm_parameter" "vpc_id" {
  count = length(var.sg_name)
  name  = "/${var.project_name}/${var.environment}/${var.sg_name[count.index]}_sg_id"
  # /roboshop/dev/catalogue_sg_id
  type  = "String"
  value = module.sg[count.index].sg_id
}