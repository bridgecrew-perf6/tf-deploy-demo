data "aws_availability_zones" "available" {
  state = "available"
}

module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.base_cidr_block
  networks = [
    {
      name     = "private-1"
      new_bits = 8
    },
    {
      name     = "private-2"
      new_bits = 8
    },
    {
      name     = "public-1"
      new_bits = 8
    },
    {
      name     = "public-2"
      new_bits = 8
    },
  ]
}

resource "aws_vpc" "main" {
  cidr_block = module.subnet_addrs.base_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "internet-gateway" {
  count  = var.public_subnet_required ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_eip" "nat" {
  count = var.public_subnet_required ? 2 : 0
  vpc   = true
}

resource "aws_nat_gateway" "internet-gateway" {
  count         = var.public_subnet_required ? 2 : 0
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  depends_on    = [aws_internet_gateway.internet-gateway]
}

resource "aws_cloudwatch_log_group" "vpc-flow-logs-group" {
  name              = "vpc-flow-logs-group"
  retention_in_days = 30
}

resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.flow-logs-delivery-role.arn
  log_destination = aws_cloudwatch_log_group.vpc-flow-logs-group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

