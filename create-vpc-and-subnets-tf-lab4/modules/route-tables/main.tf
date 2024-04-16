resource "aws_route_table" "public-route-table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "public_route_table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "private_route_table"
  }
}

resource "aws_route_table_association" "public-route-table-records" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-route-table-records" {
  subnet_id      = var.private_subnet_id
  route_table_id = aws_route_table.private-route-table.id
}
