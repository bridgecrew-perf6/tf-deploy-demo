resource "aws_lb" "app_load_balancer" {
  name                       = "${var.project_name}-${var.environment}"
  enable_deletion_protection = false
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.load_balancer_security_groups
  subnets                    = var.load_balancer_subnets
  drop_invalid_header_fields = true
}

resource "aws_lb_target_group" "app_load_balancer_tg" {
  name                 = "${var.project_name}-${var.environment}"
  port                 = 443
  protocol             = "HTTPS"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 5
  health_check {
    healthy_threshold = 2
    interval          = 5
    protocol          = "HTTPS"
    timeout           = 3
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.app_load_balancer.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.load_balancer_certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.app_load_balancer_tg.id
    type             = "forward"
  }
}
