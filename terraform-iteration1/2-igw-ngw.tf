# create an internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "onyi-igw"
  }
}

# create a nat elastic ip
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]


  tags = {
    Name = "onyi-eip"
  }
}

# create a nat gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id
  depends_on    = [aws_internet_gateway.igw]


  tags = {
    Name = "onyi-nat"
  }
}
