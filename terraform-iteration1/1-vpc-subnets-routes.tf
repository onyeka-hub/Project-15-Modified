resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "onyi-vpc"
  }
}

# creating public and private subnets

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "onyi-public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "onyi-public-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "onyi-private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "onyi-private-subnet-2"
  }
}

resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "onyi-private-subnet-3"
  }
}

resource "aws_subnet" "private-subnet-4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "onyi-private-subnet-4"
  }
}

resource "aws_subnet" "private-subnet-5" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "onyi-private-subnet-5"
  }
}

resource "aws_subnet" "private-subnet-6" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-2b"

  tags = {
    Name = "onyi-private-subnet-6"
  }
}

# create route tables for public subnets
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "onyi-public-rtb"
  }
}

# create route for the public route table and attach the internet gateway
resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# associate all public subnets to the public route table
resource "aws_route_table_association" "public-subnet-assoc-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public-subnet-assoc-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-rtb.id
}

# create route tables for private subnets
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "onyi-private-rtb"
  }
}

# create route for the private route table and attach the nat gateway
resource "aws_route" "private-route" {
  route_table_id         = aws_route_table.private-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# associate all private subnets to the private route table
resource "aws_route_table_association" "private-subnet-assoc-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnet-assoc-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnet-assoc-3" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnet-assoc-4" {
  subnet_id      = aws_subnet.private-subnet-4.id
  route_table_id = aws_route_table.private-rtb.id
}
resource "aws_route_table_association" "private-subnet-assoc-5" {
  subnet_id      = aws_subnet.private-subnet-5.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-subnet-assoc-6" {
  subnet_id      = aws_subnet.private-subnet-6.id
  route_table_id = aws_route_table.private-rtb.id
}
