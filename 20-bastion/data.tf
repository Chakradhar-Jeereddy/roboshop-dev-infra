data "aws_ami" "ami" {
  owners        = ["973714476881"]
  most_recent  = true
  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "Virtualization"
    values = ["hvm"]
  }

  filter {
    name   = "Root device type"
    values = ["ebs"]
  }
}