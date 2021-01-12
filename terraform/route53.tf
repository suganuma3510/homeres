variable "domain" {}

data "aws_route53_zone" "host-zone" {
  name = var.domain
}

resource "aws_route53_zone" "sub-host-zone" {
  name = "www.${var.domain}"
}

resource "aws_route53_record" "ns_record_for_subdomain" {
  name    = aws_route53_zone.sub-host-zone.name
  zone_id = data.aws_route53_zone.host-zone.id
  records = [
    aws_route53_zone.sub-host-zone.name_servers[0],
    aws_route53_zone.sub-host-zone.name_servers[1],
    aws_route53_zone.sub-host-zone.name_servers[2],
    aws_route53_zone.sub-host-zone.name_servers[3]
  ]
  ttl  = 300
  type = "NS"
}

/* resource "aws_route53_record" "record" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.host-zone.id
  allow_overwrite = true
} */

resource "aws_route53_record" "alias-record" {
  zone_id = aws_route53_zone.sub-host-zone.zone_id
  name    = aws_route53_zone.sub-host-zone.name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
