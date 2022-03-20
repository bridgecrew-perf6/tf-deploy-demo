data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "main" {
  name                 = var.repository_name
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  encryption_configuration {
    encryption_type = "KMS"
  }
}

data "aws_iam_policy_document" "ecr_push_pull" {
  statement {
    sid    = "AllowPush"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
  }
  statement {
    sid    = "AllowPull"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
    }
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
  }
}

resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.main.name
  policy     = data.aws_iam_policy_document.ecr_push_pull.json
}

resource "aws_ecr_lifecycle_policy" "mainpolicy" {
  repository = aws_ecr_repository.main.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep 100 most recent images",
        selection = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan"
          countNumber = 100
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}

