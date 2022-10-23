# security group for external alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "ext-alb-sg" {
  name        = "ext-alb-sg"
  description = "Allow http inbound traffic to the external loadbalancer"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "ext-alb-sg"
  }
}

# security gruop rule for external loadbalancer security group
resource "aws_security_group_rule" "allow_all_ingress_port80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}

resource "aws_security_group_rule" "allow_all_ingress_port443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ext-alb-sg.id
}