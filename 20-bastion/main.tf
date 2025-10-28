/* resource "aws_instance" "terraform" {
    ami = aws_ami.ami.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow.id]
    tags = {
        Name = "terraform-1"
        Terrafrom = "true"
    }
} */