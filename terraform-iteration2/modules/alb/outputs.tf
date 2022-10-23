output "alias-name" {
  value = aws_lb.onyi-ext-alb.dns_name
}

output "zone_id" {
  value = aws_lb.onyi-ext-alb.zone_id
}