# create bation launch template
resource "aws_launch_template" "tooling-launch-template" {
  name = "tooling-lt"

  image_id = var.image_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = var.key_name

  placement {
    availability_zone = "us-east-2a"
  }

  vpc_security_group_ids = [var.tooling-sg]


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "tooling-template"
    }
  }

  user_data = filebase64("${path.module}/bin/tooling.sh")
}

# create auto scaling group for bastion

resource "aws_autoscaling_group" "tooling-asg" {
  name                      = "tooling-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    var.tooling_subnet,
    var.tooling_subnet2
  ]

  launch_template {
    id      = aws_launch_template.tooling-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "tooling-server"
    propagate_at_launch = true
  }
}