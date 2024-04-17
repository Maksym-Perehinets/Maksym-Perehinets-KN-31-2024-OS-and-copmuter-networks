# resource "aws_instance" "public" {
#   ami                    = var.ami
#   instance_type          = "t2.micro"
#   key_name               = var.key_pair
#   subnet_id              = var.public_subnet_id
#   vpc_security_group_ids = var.allow_ssh_security_group
# }

resource "aws_launch_template" "public-subnet-template" {
  name_prefix            = "public-subnet-ec2"
  image_id               = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.public_subnet_id
    security_groups             = var.allow_ssh_security_group
  }
}

resource "aws_autoscaling_group" "public-subnet-vms" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  target_group_arns = var.arn

  vpc_zone_identifier = [var.public_subnet_id]

  launch_template {
    id      = aws_launch_template.public-subnet-template.id
    version = "$Latest"
  }
}

## requested redoo from singl ec2 to autoscaling group

# resource "aws_instance" "private" {
#   ami                    = var.ami
#   instance_type          = "t2.micro"
#   key_name               = var.key_pair
#   subnet_id              = var.private_subnet_id
#   vpc_security_group_ids = var.allow_local_security_group
# }

resource "aws_launch_template" "privat-subnet-template" {
  name_prefix            = "privat-subnet-ec2"
  image_id               = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = var.private_subnet_id
    security_groups             = var.allow_local_security_group
  }
}

resource "aws_autoscaling_group" "privat-subnet-vms" {
  desired_capacity = 2
  max_size         = 2
  min_size         = 1

  target_group_arns = var.arn

  vpc_zone_identifier = [var.private_subnet_id]

  launch_template {
    id      = aws_launch_template.privat-subnet-template.id
    version = "$Latest"
  }
}


