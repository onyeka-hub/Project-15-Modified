# security group for external alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Allow http and ssh inbound traffic to the nginx proxy"
  vpc_id      = var.vpc_id

  tags = {
    Name = "nginx-sg"
  }
}

# security gruop rule for nginx security group
resource "aws_security_group_rule" "inbound-nginx-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nginx-sg.id
  source_security_group_id = aws_security_group.ext-alb-sg.id
}

resource "aws_security_group_rule" "inbound-nginx-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nginx-sg.id
  source_security_group_id = aws_security_group.ext-alb-sg.id
}

resource "aws_security_group_rule" "inbound-bastion-ssh-to-nginx" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nginx-sg.id
  source_security_group_id = aws_security_group.bastion-sg.id
}

resource "aws_security_group_rule" "allow_all_nginx_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nginx-sg.id
}