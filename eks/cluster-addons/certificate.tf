resource "aws_acm_certificate" "cert" {
  domain_name       = "appstellar.training"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.appstellar.training"
  ]

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Validate SSL with DNS 
resource "aws_route53_record" "dns_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.hosted_zone.zone_id
}