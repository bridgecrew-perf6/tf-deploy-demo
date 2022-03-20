resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "database" {
  count  = var.enable_postgresql_access ? 1 : 0
  name   = "database_sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "load_balancer" {
  count  = var.enable_postgresql_access ? 1 : 0
  name   = "load_balancer_sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "web_app" {
  count  = var.enable_postgresql_access ? 1 : 0
  name   = "web_app_sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow_postgresql_from_webapp" {
  count                    = var.enable_postgresql_access ? 1 : 0
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_app[0].id
  security_group_id        = aws_security_group.database[0].id
}

resource "aws_security_group_rule" "allow_postgresql_to_db" {
  count                    = var.enable_postgresql_access ? 1 : 0
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.database[0].id
  security_group_id        = aws_security_group.web_app[0].id
}

resource "aws_security_group_rule" "allow_https_to_webapp" {
  count                    = var.enable_web_app_access ? 1 : 0
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.load_balancer[0].id
  security_group_id        = aws_security_group.web_app[0].id
}

resource "aws_security_group_rule" "allow_https_to_lb" {
  count             = var.enable_postgresql_access ? 1 : 0
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.load_balancer[0].id
}

resource "aws_security_group_rule" "allow_https_to_app" {
  count                    = var.enable_postgresql_access ? 1 : 0
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_app[0].id
  security_group_id        = aws_security_group.load_balancer[0].id
}

resource "aws_security_group_rule" "allow_app_to_internet" {
  count             = var.enable_web_app_access ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_app[0].id
}
