output "ami_id" {
    value = data.aws_ami.ami.id
}

output "sg_id" {
    value = data.aws_ssm_parameter.bastion_sg_id
    sensitive = true
}