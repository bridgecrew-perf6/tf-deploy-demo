
resource "aws_cloudwatch_log_group" "cluster_log_group" {
  name              = "/ecs/cluster-${var.project_name}-${var.environment}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "task_log_group" {
  name              = "/ecs/task-${var.project_name}-${var.environment}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "task_runner_log_group" {
  name              = "/ecs/task-${var.project_name}-${var.environment}-runner"
  retention_in_days = 30
}

resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.project_name}-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.cluster_log_group.name
      }
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "app" {
  cluster_name = aws_ecs_cluster.app_cluster.name

  capacity_providers = ["FARGATE"]
}


