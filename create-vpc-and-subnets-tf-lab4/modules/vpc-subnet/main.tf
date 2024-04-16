resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_security_group" "allow-ssh" {
  vpc_id = resource.aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow-for-private" {
  vpc_id = resource.aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_subnet" "main-private" {
  vpc_id     = resource.aws_vpc.main.id
  cidr_block = var.desired_cdir

  tags = {
    Name = "main_subnet"
  }
}

resource "aws_subnet" "supplemental-public" {
  vpc_id                  = resource.aws_vpc.main.id
  cidr_block              = var.desired_cdir_for_public
  map_public_ip_on_launch = "true"

  tags = {
    Name = "additional_subnet"
  }
}

resource "aws_internet_gateway" "subnet-gateway" {
  vpc_id = resource.aws_vpc.main.id
}
