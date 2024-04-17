output "arn" {
  value = resource.aws_lb_target_group.ssh-target-group.arn
}

output "load_balancer_dns_name" {
  value = aws_lb.ssh-lb.dns_name
}
