# create bation launch template
resource "aws_launch_template" "nginx-launch-template" {
  name = "nginx-lt"

  image_id = var.nginx_image_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = var.key_name

  placement {
    availability_zone = "us-east-2a"
  }

  vpc_security_group_ids = [var.nginx-sg]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx-launch-template"
    }
  }

  user_data = filebase64("${path.module}/bin/nginx.sh")
}

# create auto scaling group for bastion

resource "aws_autoscaling_group" "nginx-asg" {
  name                      = "nginx-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    var.nginx_subnet,
    var.nginx_subnet2
  ]

  launch_template {
    id      = aws_launch_template.nginx-launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nginx-server"
    propagate_at_launch = true
  }
}