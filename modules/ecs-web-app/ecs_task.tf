locals {
  task_environment = [
    for k, v in var.environment_variables : {
      name  = k
      value = v
    }
  ]
}

locals {
  task_secrets = [
    for k, v in var.secrets : {
      name      = k
      valueFrom = v
    }
  ]
}

data "aws_region" "current" {}

resource "aws_ecs_task_definition" "app" {
  family             = "${var.project_name}-${var.environment}"
  network_mode       = "awsvpc"
  task_role_arn      = aws_iam_role.ecs_task.arn
  execution_role_arn = aws_iam_role.ecs_exec.arn
  cpu                = var.cpu
  memory             = var.memory
  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-${var.environment}"
      image     = var.repository_url
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.task_log_group.name,
          awslogs-region        = data.aws_region.current.name,
          awslogs-stream-prefix = "ecs"
        }
      },
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
      environment = local.task_environment
      secrets     = local.task_secrets
    }
  ])
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_task_definition" "runner" {
  family             = "${var.project_name}-${var.environment}-runner"
  network_mode       = "awsvpc"
  task_role_arn      = aws_iam_role.ecs_task.arn
  execution_role_arn = aws_iam_role.ecs_exec.arn
  cpu                = var.cpu
  memory             = var.memory
  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-${var.environment}-runner"
      image     = var.repository_url
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      command   = var.task_runner_command
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.task_log_group.name}-runner",
          awslogs-region        = data.aws_region.current.name,
          awslogs-stream-prefix = "ecs"
        }
      },
      environment = local.task_environment
      secrets     = local.task_secrets
    }
  ])
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
