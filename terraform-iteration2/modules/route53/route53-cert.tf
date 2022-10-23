# The entire section create a certificate, public zone, and validate the certificate using DNS method

# Create the certificate using a wildcard for all the domains created in onyeka.ga
resource "aws_acm_certificate" "onyeka" {
  domain_name       = "*.onyeka.ga"
  validation_method = "DNS"
}

# selecting validation method
resource "aws_route53_record" "onyeka" {
  for_each = {
    for dvo in aws_acm_certificate.onyeka.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.primary.zone_id
}

# validate the certificate through DNS method
resource "aws_acm_certificate_validation" "onyeka" {
  certificate_arn         = aws_acm_certificate.onyeka.arn
  validation_record_fqdns = [for record in aws_route53_record.onyeka : record.fqdn]
}


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
