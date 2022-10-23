# create bation launch template
resource "aws_launch_template" "wordpress-launch-template" {
  name = "wordpress-lt"

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

  vpc_security_group_ids = [var.wordpress-sg]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx-launch-template"
    }
  }

  user_data = filebase64("${path.module}/bin/wordpress.sh")
}

# create auto scaling group for wordpress

resource "aws_autoscaling_group" "wordpress-asg" {
  name                      = "wordpress-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    var.wordpress_subnet,
    var.wordpress_subnet2
  ]

  launch_template {
    id      = aws_launch_template.wordpress-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "wordpress-server"
    propagate_at_launch = true
  }
}