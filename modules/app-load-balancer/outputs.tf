output "dns_name" {
  value       = aws_lb.app_load_balancer.dns_name
  description = "Hostname of app load balancer"
}

output "target_group" {
  value = aws_lb_target_group.app_load_balancer_tg.arn
}
