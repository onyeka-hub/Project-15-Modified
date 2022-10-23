resource "aws_lb" "onyi-ext-alb" {
  name               = "onyi-ext-alb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [var.ext_alb_sg]

  subnets = [
    var.ext_alb_subnet,
    var.ext_alb_subnet2
  ]

  tags = {
    Name = "ext-alb"
  }
}

#--- create a target group for the external load balancer
resource "aws_lb_target_group" "nginx-tgt" {
  name        = "nginx-tgt"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = "HTTPS"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

#--- create a listener for the load balancer
resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.onyi-ext-alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tgt.arn
  }
}

