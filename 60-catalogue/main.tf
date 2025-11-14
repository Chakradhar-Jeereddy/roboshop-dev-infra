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

resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name_suffix}-catalogue"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  deregistration_delay = 60 # Waiting period before deleting the instance
  health_check {
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 2
  }
}

resource "aws_launch_template" "catalogue" {
  name_prefix = "${local.common_name_suffix}-catalogue"
  image_id      = aws_ami_from_instance.catalogue.id # Replace with your desired AMI ID
  instance_type = "t3.micro"
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids = [local.catalogue_sg_id]
  # tags attached to the instance
  tag_specifications {
    resource_type = "instance"
    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue" #roboshop-dev-catalogue
      }
    ) 
  }
  # tags attached to the volumes created
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue" #roboshop-dev-catalogue
      }
    )
  }

  # tags attached to the launch template
  tags = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue" #roboshop-dev-catalogue
      }
  )
}

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name_suffix}-catalogue"
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
  vpc_zone_identifier       = local.private_subnet_ids
  target_group_arns = [ aws_lb_target_group.catalogue.arn ]
  launch_template {
    id = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
  }

  dynamic "tag" {
    for_each = merge(
      local.common_tags,
      {
        Name = "${local.common_name_suffix}-catalogue"
      }
    )
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
      
    }
  }
  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  name                   = "${local.common_name_suffix}-catalogue"
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0 # Target 60% CPU utilization
    }
}