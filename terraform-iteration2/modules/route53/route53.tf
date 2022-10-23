# create hosted zone
resource "aws_route53_zone" "primary" {
  name          = "onyeka.ga"
  force_destroy = "true"

  tags = {
    Name = format("%s-zone", var.name)
  }
}


# create records
resource "aws_route53_record" "tooling" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "tooling.onyeka.ga"
  type    = "A"

  alias {
    name                   = var.alias-name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wordpress" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "wordpress.onyeka.ga"
  type    = "A"

  alias {
    name                   = var.alias-name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}
