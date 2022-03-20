data "aws_route53_zone" "example" {
  name         = "example.com"
  private_zone = false
}

resource "aws_route53_record" "app" {
  allow_overwrite = true
  name            = local.domain_name
  type            = "A"
  zone_id         = data.aws_route53_zone.example.id
  alias {
    name                   = module.cloudfront.domain_name
    zone_id                = module.cloudfront.hosted_zone_id
    evaluate_target_health = true
  }
}
