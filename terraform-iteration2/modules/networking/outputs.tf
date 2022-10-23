output "vpc_id" {
  value = aws_vpc.main.id
}
output "bastion_subnet" {
  value = aws_subnet.public[0].id
}
output "bastion_subnet2" {
  value = aws_subnet.public[1].id
}
output "nginx_subnet" {
  value = aws_subnet.nginx_private[0].id
}
output "nginx_subnet2" {
  value = aws_subnet.nginx_private[1].id
}
output "tooling_subnet" {
  value = aws_subnet.compute_private[0].id
}
output "tooling_subnet2" {
  value = aws_subnet.compute_private[1].id
}

output "wordpress_subnet" {
  value = aws_subnet.compute_private[0].id
}
output "wordpress_subnet2" {
  value = aws_subnet.compute_private[1].id
}

output "ext_alb_subnet" {
  value = aws_subnet.public[0].id
}
output "ext_alb_subnet2" {
  value = aws_subnet.public[1].id
}

output "int_alb_subnet" {
  value = aws_subnet.nginx_private[0].id
}
output "int_alb_subnet2" {
  value = aws_subnet.nginx_private[1].id
}
output "data_subnet" {
  value = aws_subnet.data_private[0].id
}
output "data_subnet2" {
  value = aws_subnet.data_private[1].id
}
output "efs_subnet" {
  value = aws_subnet.compute_private[0].id
}
output "efs_subnet2" {
  value = aws_subnet.compute_private[1].id
}
output "aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}