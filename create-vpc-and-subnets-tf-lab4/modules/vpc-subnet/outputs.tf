output "vpc_id" {
  value = resource.aws_vpc.main.id
}

output "allow_ssh_id" {
  value = resource.aws_security_group.allow-ssh.id
}


output "allow_local_id" {
  value = resource.aws_security_group.allow-for-private.id
}

output "private_subnet_id" {
  value = resource.aws_subnet.main-private.id
}

output "public_subnet_id" {
  value = resource.aws_subnet.supplemental-public.id
}

output "gateway_id" {
  value = resource.aws_internet_gateway.subnet-gateway.id
}
