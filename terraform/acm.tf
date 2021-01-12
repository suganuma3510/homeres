/* resource "aws_acm_certificate" "certificate" {
  domain_name               = data.aws_route53_zone.host-zone.name
  subject_alternative_names = [format("*.%s", data.aws_route53_zone.host-zone.name)]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "certificate-val" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
} */