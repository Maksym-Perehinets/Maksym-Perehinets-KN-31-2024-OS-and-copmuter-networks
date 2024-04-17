# output "public_ip" {
#   value = module.ec2.public_ip
# }

# output "private_ip" {
#   value = module.ec2.private
# }

output "load_balancer_dns_name" {
  value = module.route-tables.load_balancer_dns_name
}