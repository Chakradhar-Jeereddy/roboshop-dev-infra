data "aws_ami" "ami" {
  executable_users = ["self"]
  filter {
    name   = "image-id"
    values = ["ami-09c813fb71547fc4f"]
  }
}