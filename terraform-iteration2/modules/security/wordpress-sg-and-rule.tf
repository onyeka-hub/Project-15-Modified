# security group for wordpress server, to allow access from internal loadbalancer to wordpress server for ssh, HTTP and HTTPS traffic
resource "aws_security_group" "wordpress-sg" {
  name        = "wordpress-sg"
  description = "Allow http and ssh inbound traffic to the wordpress server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "wordpress-sg"
  }
}

# security group rule for wordpress security group
resource "aws_security_group_rule" "inbound-wordpress-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.wordpress-sg.id
  source_security_group_id = aws_security_group.int-alb-sg.id
}

resource "aws_security_group_rule" "inbound-wordpress-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.wordpress-sg.id
  source_security_group_id = aws_security_group.int-alb-sg.id
}

resource "aws_security_group_rule" "inbound-bastion-ssh-to-wordpress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.wordpress-sg.id
  source_security_group_id = aws_security_group.bastion-sg.id
}

resource "aws_security_group_rule" "allow_all_wordpress_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.wordpress-sg.id
}