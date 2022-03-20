resource "aws_acm_certificate" "cloudfront_cert" {
  domain_name       = local.domain_name
  validation_method = "DNS"

  tags = {
    Environment = local.environment
  }

  lifecycle {
    create_before_destroy = true
  }
  provider = aws.virginia
}

resource "aws_route53_record" "cloudfront_cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cloudfront_cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cloudfront_cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cloudfront_cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.example.id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "cloudfront_cert" {
  certificate_arn         = aws_acm_certificate.cloudfront_cert.arn
  validation_record_fqdns = [aws_route53_record.cloudfront_cert_validation.fqdn]
  provider                = aws.virginia
}

resource "aws_acm_certificate" "lb_cert" {
  domain_name       = local.domain_name
  validation_method = "DNS"

  tags = {
    Environment = local.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "lb_cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.lb_cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.lb_cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.lb_cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.example.id
  ttl             = 60
}

resource "aws_acm_certificate_validation" "lb_cert" {
  certificate_arn         = aws_acm_certificate.lb_cert.arn
  validation_record_fqdns = [aws_route53_record.lb_cert_validation.fqdn]
}
