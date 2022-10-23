# create hosted zone
resource "aws_route53_zone" "primary" {
  name          = "onyeka.ga"
  force_destroy = "true"

  tags = {
    Name = "onyi-zone"
  }
}

# create records
resource "aws_route53_record" "tooling" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "tooling.onyeka.ga"
  type    = "CNAME"
  ttl     = 5
  records = ["tooling.onyeka.ga"]
}

resource "aws_route53_record" "wordpress" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "wordpress.onyeka.ga"
  type    = "CNAME"
  ttl     = 5
  records = ["wordpress.onyeka.ga"]
}
