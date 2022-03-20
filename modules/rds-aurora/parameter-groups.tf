resource "aws_db_parameter_group" "example-default-12" {
  name   = "example-default-12"
  family = "aurora-postgresql12"

  parameter {
    name  = "log_min_duration_statement"
    value = 100
  }
}

resource "aws_db_parameter_group" "example-default-13" {
  name   = "example-default-13"
  family = "aurora-postgresql13"

  parameter {
    name  = "log_min_duration_statement"
    value = 100
  }
}

resource "aws_rds_cluster_parameter_group" "example-default-cluster-12" {
  name   = "example-default-cluster-12"
  family = "aurora-postgresql12"
  parameter {
    name  = "log_min_duration_statement"
    value = 100
  }
}

resource "aws_rds_cluster_parameter_group" "example-default-cluster-13" {
  name   = "example-default-cluster-13"
  family = "aurora-postgresql13"
  parameter {
    name  = "log_min_duration_statement"
    value = 100
  }
}
