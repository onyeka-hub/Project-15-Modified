# security group for internal alb, to allow acess for HTTP and HTTPS traffic
resource "aws_security_group" "int-alb-sg" {
  name        = "int-alb-sg"
  description = "Allow http inbound traffic to the internal loadbalancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "int-alb-sg"
  }
}

# security gruop rule for internal loadbalancer security group
resource "aws_security_group_rule" "inbound-int-alb-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.int-alb-sg.id
  source_security_group_id = aws_security_group.nginx-sg.id
}

resource "aws_security_group_rule" "inbound-int-alb-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.int-alb-sg.id
  source_security_group_id = aws_security_group.nginx-sg.id
}

resource "aws_security_group_rule" "allow_all_int-alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.int-alb-sg.id
}