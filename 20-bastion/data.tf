data "aws_ami" "ami" {
  executable_users = ["self"]

  filter {
    name   = "source-image-region"
    values = ["us-east-1"]
  }

   filter {
    name   = "owner-alias"
    values = ["RHEL-9-DevOps-Practice"]
  }
}