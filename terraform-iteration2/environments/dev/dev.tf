aws_region             = "us-east-2"
vpc_cidr               = "10.0.0.0/16"
name                   = "onyi"
public_subnet          = ["10.0.1.0/24", "10.0.2.0/24"]
nginx_private_subnet   = ["10.0.3.0/24", "10.0.4.0/24"]
compute_private_subnet = ["10.0.5.0/24", "10.0.6.0/24"]
data_private_subnet    = ["10.0.7.0/24", "10.0.8.0/24"]
image_id               = "ami-092b43193629811af"
nginx_image_id         = "ami-0d5bf08bc8017c83b"
instance_type          = "t2.micro"
key_name               = "onyi-ohio"
max_size               = 2
min_size               = 1
desired_capacity       = 1
db_name                = "onyidb"
username               = "onyi"
password               = "onyeka123"
multi_az               = "false"
