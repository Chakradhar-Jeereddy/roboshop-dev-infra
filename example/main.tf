resource "aws_security_group" "example" {
  name        = "example"
  description = "my-sec-group"
  vpc_id      = "vpc-0117f6863d76505eb"
}

resource "aws_security_group" "example_rules" {
  count = length(var.port_range)
  name        = var.port_range[count.index]
  description = "Allow HTTP and SSH inbound"
  vpc_id      = "vpc-0117f6863d76505eb"

  ingress {
    from_port   = 80
    to_port     = var.port_range[count.index]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP inbound"
  }
}