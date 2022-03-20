resource "aws_subnet" "private" {
  count             = 2
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id
  cidr_block        = module.subnet_addrs.network_cidr_blocks["private-${count.index + 1}"]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "public" {
  count             = var.public_subnet_required ? 2 : 0
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.main.id
  cidr_block        = module.subnet_addrs.network_cidr_blocks["public-${count.index + 1}"]

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}
