data "aws_iam_policy_document" "vpc_flow_logs_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "flow-logs-delivery-role" {
  name               = "flow-logs-delivery-role"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume.json
}

data "aws_iam_policy_document" "logs_delivery" {
  statement {
    effect    = "Allow"
    resources = [aws_cloudwatch_log_group.vpc-flow-logs-group.arn]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
  }
}

resource "aws_iam_role_policy" "logging" {
  name   = "logging"
  role   = aws_iam_role.flow-logs-delivery-role.id
  policy = data.aws_iam_policy_document.logs_delivery.json
}
