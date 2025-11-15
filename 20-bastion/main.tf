# Create instance in public network to connect databases and configure them remotely.
resource "aws_instance" "terraform" {
    ami = local.ami_id
    subnet_id = local.public_subnet_id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.bastion_sg_id.value]
    user_data = file("bastion.sh")
    iam_instance_profile = aws_iam_instance_profile.bastion.name
    tags = merge(
       local.common_tags,
       {
         Name = "${var.project_name}-${var.environment}-bastion"
       }
    )
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = "BastionTerraformAdmin"
  
}