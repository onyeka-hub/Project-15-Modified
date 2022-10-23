# create bation launch template
resource "aws_launch_template" "nginx-launch-template" {
  name = "nginx-lt"

  image_id = "ami-092b43193629811af"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "onyi-ohio"

  placement {
    availability_zone = "us-east-2a"
  }

  vpc_security_group_ids = [aws_security_group.nginx-sg.id]

  iam_instance_profile {
    name = var.instance_profile
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx server"
    }
  }

  user_data = filebase64("${path.module}/bin/nginx.sh")
}

# create auto scaling group for bastion

resource "aws_autoscaling_group" "nginx-asg" {
  name                      = "nginx-asg"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    aws_subnet.private-subnet-1.id,
    aws_subnet.private-subnet-2.id
  ]

  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nginx-asg"
    propagate_at_launch = true
  }
}