
resource "random_shuffle" "az_list" {
  input = var.aws_availability_zones
}

# create bation launch template
resource "aws_launch_template" "bastion-launch-template" {
  name = "bastion-lt"

  image_id = var.image_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = var.key_name

  placement {
    availability_zone = "random_shuffle.az_list.result"
  }
  lifecycle {
    create_before_destroy = true
  }

  vpc_security_group_ids = [var.bastion-sg]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "bastion lt"
    }
  }

  user_data = filebase64("${path.module}/bin/bastion.sh")
}

# create auto scaling group for bastion

resource "aws_autoscaling_group" "bastion-asg" {
  name                      = "bastion-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    var.bastion_subnet,
    var.bastion_subnet2
  ]

  launch_template {
    id      = aws_launch_template.bastion-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "bastion-server"
    propagate_at_launch = true
  }
}