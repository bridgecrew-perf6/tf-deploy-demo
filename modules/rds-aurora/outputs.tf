output "secret_arn" {
  value = data.aws_secretsmanager_secret.rds-secret.arn
}

output "database_name" {
  value = aws_rds_cluster.postgresql.database_name
}

output "writer_endpoint" {
  value = aws_rds_cluster.postgresql.endpoint
}

output "reader_endpoint" {
  value = aws_rds_cluster.postgresql.reader_endpoint
}
