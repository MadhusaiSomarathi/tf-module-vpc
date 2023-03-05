resource "aws_subnet" "main" {
  count             = length(var.cidr_block) //2
  vpc_id            = var.vpc_id
  cidr_block        = element(var.cidr_block, count.index) //(["10.0.0.0/24", "10.0.1.0/24"],0) (["10.0.0.0/24", "10.0.1.0/24"],1)
  tags              = local.subnet_tags
  availability_zone = element(var.subnet_availability_zones, count.index) //(["us-east-1a", "us-east-1b"],0) (["us-east-1a", "us-east-1b"],1)
}

resource "aws_route_table" "aws_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name    = "${var.env}-${var.name}-rt"
    ENV     = var.env
    PROJECT = "roboshop"
  }
}

resource "aws_route_table_association" "route-table-association" {
  count          = length(aws_subnet.main) //2
  subnet_id      = element(aws_subnet.main.*.id, count.index) //(["subnet-0a74919a7fd5254da","subnet-08d1fa9f0d40bc061"],0) (["subnet-0a74919a7fd5254da","subnet-08d1fa9f0d40bc061"],1)
  route_table_id = aws_route_table.aws_route_table.id
}

resource "aws_route" "internet_gateway_route" {
  route_table_id         = aws_route_table.aws_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
}


