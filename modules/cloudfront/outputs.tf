output "domain_name" {
  value = aws_cloudfront_distribution.app_distribution.domain_name
}

output "hosted_zone_id" {
  value = aws_cloudfront_distribution.app_distribution.hosted_zone_id
}
