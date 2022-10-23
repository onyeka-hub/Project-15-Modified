# create vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = format("%s-vpc", var.name)
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# creating public and private subnets

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${format("public-subnet-%02d", count.index + 1)}"
  }
}

resource "aws_subnet" "nginx_private" {
  count                   = length(var.nginx_private_subnet)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.nginx_private_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${format("NginxPrivateSubnet-%02d", count.index + 1)}"
  }
}


resource "aws_subnet" "compute_private" {
  count                   = length(var.compute_private_subnet)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.compute_private_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${format("ComputePrivateSubnet-%02d", count.index + 1)}"
  }
}

resource "aws_subnet" "data_private" {
  count                   = length(var.data_private_subnet)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.data_private_subnet[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "${format("DataPrivateSubnet-%02d", count.index + 1)}"
  }
}
