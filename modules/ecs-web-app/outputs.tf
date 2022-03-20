output "task_role" {
  value = aws_iam_role.ecs_task.arn
}

output "task_exec_role" {
  value =  aws_iam_role.ecs_exec.arn
}
