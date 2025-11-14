# Create EC2 Instance
resource "aws_instance" "catalogue" {
    ami = local.ami_id
    subnet_id = local.private_subnet_id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.catalogue_sg_id]
    tags = merge(
       local.common_tags,
       {
         Name = "${local.common_name_suffix}-catalogue" #roboshop-dev-catalogue
       }
    )
}

# Connect to instance using remote-exec provisioner through terraform_data

resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id  #trigger when ID is changed.
  ]

connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.catalogue.private_ip
}

# terrafrom copy this file to catalogue server
provisioner "file" {
    source      = "catalogue.sh"
    destination = "/tmp/catalogue.sh"
}

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/catalogue.sh",
        #"sudo sh /tmp/bootstrap.sh"
        "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
    ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state       = "stopped"
  force       = false # Set to true for a forced stop (use with caution)
  depends_on = [ terraform_data.catalogue ]
}

resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-catalogue-ami" #roboshop-dev-catalogue-ami
    }
  )

}