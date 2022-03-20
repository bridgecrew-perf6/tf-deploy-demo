resource "random_password" "password" {
  length           = 40
  special          = true
  min_special      = 5
  override_special = "!#$%^&*()-_=+[]{}<>:?"
  keepers = {
    pass_version = 1
  }
}

resource "aws_secretsmanager_secret" "rds-secret" {
  name_prefix = var.cluster_name
}

resource "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = aws_secretsmanager_secret.rds-secret.id
  secret_string = jsonencode({
    "username" : var.username,
    "password" : "${random_password.password.result}",
  })
}

data "aws_secretsmanager_secret" "rds-secret" {
  arn = aws_secretsmanager_secret.rds-secret.arn
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = data.aws_secretsmanager_secret.rds-secret.arn
}

data "aws_rds_cluster" "postgresql" {
  cluster_identifier = var.cluster_name
  depends_on         = [aws_rds_cluster.postgresql, aws_rds_cluster_instance.postgresql_cluster_instance]
}

resource "aws_secretsmanager_secret_version" "complete-secret-version" {
  secret_id = aws_secretsmanager_secret.rds-secret.id
  secret_string = jsonencode(
    merge(
      local.db_creds,
      {
        db_cluster_identifier = data.aws_rds_cluster.postgresql.cluster_identifier,
        db_name               = data.aws_rds_cluster.postgresql.database_name,
        engine                = data.aws_rds_cluster.postgresql.engine,
        port                  = data.aws_rds_cluster.postgresql.port,
        writer_endpoint       = data.aws_rds_cluster.postgresql.endpoint,
        reader_endpoint       = data.aws_rds_cluster.postgresql.reader_endpoint
    })
  )
}
