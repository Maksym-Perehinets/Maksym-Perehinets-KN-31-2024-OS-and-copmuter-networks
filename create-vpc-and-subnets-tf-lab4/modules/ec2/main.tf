resource "aws_instance" "public" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.allow_ssh_security_group
}

resource "aws_instance" "private" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_pair
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = var.allow_local_security_group
}


