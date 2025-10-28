data "aws_ami" "ami" {
  executable_users = ["self"]

  filter {
    name   = "source-image-region"
    values = ["us-east-1"]
  }

   filter {
    name   = "image-id"
    values = ["ami-09c813fb71547fc4f"]
  }
}