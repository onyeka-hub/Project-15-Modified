# create tooling launch template
resource "aws_launch_template" "tooling-launch-template" {
  name = "tooling-lt"

  image_id = "ami-092b43193629811af"

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  key_name = "onyi-ohio"

  placement {
    availability_zone = "us-east-2a"
  }

  vpc_security_group_ids = [aws_security_group.tooling-sg.id]

  iam_instance_profile {
    name = var.instance_profile
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "tooling server"
    }
  }

  user_data = filebase64("${path.module}/bin/tooling.sh")
}

# create auto scaling group for tooling

resource "aws_autoscaling_group" "tooling-asg" {
  name                      = "tooling-asg"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    aws_subnet.private-subnet-3.id,
    aws_subnet.private-subnet-4.id
  ]

  launch_template {
    id      = aws_launch_template.tooling-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "tooling-asg"
    propagate_at_launch = true
  }
}