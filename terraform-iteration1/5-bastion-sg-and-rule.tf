# security group for external alb, to allow acess from any where for HTTP and HTTPS traffic
resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allow ssh inbound traffic to the bastion"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "bastion-sg"
  }
}

# security gruop rule for bastion security group
resource "aws_security_group_rule" "inbound-bastion-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion-sg.id
}

resource "aws_security_group_rule" "allow_all_bastion_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion-sg.id
}