resource "aws_instance" "terraform" {
    ami = local.ami_id
    subnet_id = "subnet-0a9cadc4bb84947ba"
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.bastion_sg_id.value]
    tags = merge(
       local.common_tags,
       {
         Name = "${var.project_name}-${var.environment}-bastion"
       }
    )
}