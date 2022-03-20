data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier                  = var.cluster_name
  engine                              = "aurora-postgresql"
  iam_database_authentication_enabled = true
  engine_version                      = var.engine_version
  database_name                       = var.database_name
  master_username                     = local.db_creds.username
  master_password                     = local.db_creds.password
  db_cluster_parameter_group_name     = "example-default-cluster-${split(".", var.engine_version)[0]}"
  backup_retention_period             = 7
  preferred_backup_window             = "02:00-03:00"
  enabled_cloudwatch_logs_exports     = ["postgresql"]
  db_subnet_group_name                = aws_db_subnet_group.aurora_subnet_group.name
  skip_final_snapshot                 = true
  vpc_security_group_ids              = var.security_groups
  deletion_protection                 = true
  storage_encrypted                   = true
  lifecycle {
    create_before_destroy = false
  }
  tags = {
    Name = var.cluster_name
  }
  # provisioner "local-exec" {
  #   command = "aws logs put-retention-policy --log-group-name /aws/rds/cluster/${var.cluster_name}/postgresql --retention-in-days 30"
  # }
}

resource "aws_rds_cluster_instance" "postgresql_cluster_instance" {
  count                      = var.instance_count
  identifier                 = "${var.cluster_name}-postgresql-instance-${count.index}"
  cluster_identifier         = aws_rds_cluster.postgresql.id
  instance_class             = var.instance_class
  availability_zone          = var.availability_zones[count.index]
  db_subnet_group_name       = aws_db_subnet_group.aurora_subnet_group.name
  engine                     = "aurora-postgresql"
  engine_version             = var.engine_version
  db_parameter_group_name    = "example-default-${split(".", var.engine_version)[0]}"
  publicly_accessible        = false
  monitoring_interval        = 5
  auto_minor_version_upgrade = true
  monitoring_role_arn        = aws_iam_role.monitoring_role.arn
  lifecycle {
    create_before_destroy = false
  }
  tags = {
    Name = "${var.cluster_name}-postgresql-instance-${count.index}"
  }
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name        = "${var.cluster_name}_aurora_db_subnet_group"
  description = "Allowed subnets for Aurora DB cluster instances"
  subnet_ids  = var.subnet_ids
}

resource "aws_iam_role" "monitoring_role" {
  name               = "rds_enhanced_monitoring_role"
  assume_role_policy = data.aws_iam_policy_document.rds_assume_role.json
  inline_policy {
    name   = "monitoring_policy"
    policy = data.aws_iam_policy_document.monitroing_logs_to_cloudwatch.json
  }
}

data "aws_iam_policy_document" "monitroing_logs_to_cloudwatch" {
  statement {
    sid    = "EnableCreationAndManagementOfRDSCloudwatchLogGroups"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:PutRetentionPolicy"
    ]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:RDS*"]
  }
  statement {
    sid    = "EnableCreationAndManagementOfRDSCloudwatchLogStreams"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents"
    ]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:RDS*:log-stream:*"]
  }
}

data "aws_iam_policy_document" "rds_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "monitoring.rds.amazonaws.com"
      ]
    }
  }
}
