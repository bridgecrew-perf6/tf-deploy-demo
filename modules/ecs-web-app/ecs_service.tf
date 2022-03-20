data "aws_ecs_task_definition" "current_task" {
  task_definition = aws_ecs_task_definition.app.family
}

resource "aws_ecs_service" "app" {
  name                              = "${var.project_name}-${var.environment}"
  cluster                           = aws_ecs_cluster.app_cluster.id
  task_definition                   = "${aws_ecs_task_definition.app.family}:${max(aws_ecs_task_definition.app.revision, data.aws_ecs_task_definition.current_task.revision)}"
  desired_count                     = var.instance_count
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 90

  load_balancer {
    target_group_arn = var.load_balancer_target_group
    container_name   = "${var.project_name}-${var.environment}"
    container_port   = 443
  }

  network_configuration {
    subnets         = var.app_subnets
    security_groups = var.app_security_groups
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
}
