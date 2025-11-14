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