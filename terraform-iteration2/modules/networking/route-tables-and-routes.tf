
# create route tables for public subnets
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-public-rtb", var.name)
  }
}

# create route for the public route table and attach the internet gateway
resource "aws_route" "public-route" {
  route_table_id         = aws_route_table.public-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# associate all public subnets to the public route table
resource "aws_route_table_association" "public-subnet-assoc" {
  count          = length(var.public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rtb.id
}


# create route tables for private subnets
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-private-rtb", var.name)
  }
}

# create route for the private route table and attach the nat gateway
resource "aws_route" "private-route" {
  route_table_id         = aws_route_table.private-rtb.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# associate all nginx private subnets to the private route table
resource "aws_route_table_association" "nginx-subnet-assoc" {
  count          = length(var.nginx_private_subnet)
  subnet_id      = aws_subnet.nginx_private[count.index].id
  route_table_id = aws_route_table.private-rtb.id
}

# associate all compute private subnets to the private route table
resource "aws_route_table_association" "compute-subnet-assoc" {
  count          = length(var.compute_private_subnet)
  subnet_id      = aws_subnet.compute_private[count.index].id
  route_table_id = aws_route_table.private-rtb.id
}

# associate all data private subnets to the private route table
resource "aws_route_table_association" "data-subnet-assoc" {
  count          = length(var.data_private_subnet)
  subnet_id      = aws_subnet.data_private[count.index].id
  route_table_id = aws_route_table.private-rtb.id
}
