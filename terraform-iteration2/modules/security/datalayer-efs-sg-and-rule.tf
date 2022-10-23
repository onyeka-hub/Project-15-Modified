# security group for datalayer server, to allow access from compute to db server for mysql traffic
resource "aws_security_group" "datalayer-sg" {
  name        = "datalayer-sg"
  description = "Allow mysql inbound traffic to the tooling server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "datalayer-sg"
  }
}

# security group rule for datalayer security group
resource "aws_security_group_rule" "inbound-datalayer-tooling-http" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.datalayer-sg.id
  source_security_group_id = aws_security_group.tooling-sg.id
}

resource "aws_security_group_rule" "inbound-datalayer-wordpress-http" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.datalayer-sg.id
  source_security_group_id = aws_security_group.wordpress-sg.id
}

resource "aws_security_group_rule" "inbound-datalayer-from-bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.datalayer-sg.id
  source_security_group_id = aws_security_group.bastion-sg.id
}

resource "aws_security_group_rule" "allow_from_tooling_web_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.wordpress-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}


resource "aws_security_group_rule" "allow_from_wordpress_web_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.tooling-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}

resource "aws_security_group_rule" "allow_from_bastion_to_efs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion-sg.id
  security_group_id        = aws_security_group.datalayer-sg.id
}

resource "aws_security_group_rule" "allow_all_datalayer_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.datalayer-sg.id
}