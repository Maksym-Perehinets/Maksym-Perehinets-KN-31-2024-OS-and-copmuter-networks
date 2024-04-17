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

resource "aws_lb" "ssh-lb" {
  name               = "ssh-load-balancer"
  internal           = false
  load_balancer_type = "network"
  subnets            = [var.public_subnet_id]
}

resource "aws_lb_target_group" "ssh-target-group" {
  name     = "ssh-target-group"
  port     = 22
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "ssh-istener" {
  load_balancer_arn = resource.aws_lb.ssh-lb.arn
  port              = 22
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = resource.aws_lb_target_group.ssh-target-group.arn
  }
}