resource "aws_db_subnet_group" "onyi-rds-subnet-group" {
  name = "onyi-rds-subnet-group"
  subnet_ids = [aws_subnet.private-subnet-5.id,
  aws_subnet.private-subnet-6.id]

  tags = {
    Name = "onyi-rds-subnet-group"
  }
}

# create the RDS instance with the subnets group
resource "aws_db_instance" "onyi-RDS" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "onyiDB"
  username               = "onyi"
  password               = "onyeka123"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.onyi-rds-subnet-group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.datalayer-sg.id]
  multi_az               = "false"
}
