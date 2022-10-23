resource "aws_db_subnet_group" "onyi-rds-subnet-group" {
  name = "onyi-rds-subnet-group"
  subnet_ids = [
    var.data_subnet,
    var.data_subnet2
  ]

  tags = {
    Name = format("%s-rds-subnet-group", var.name)
  }
}

# create the RDS instance with the subnets group
resource "aws_db_instance" "onyiRDS" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.onyi-rds-subnet-group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.data-sg]
  multi_az               = var.multi_az
}
