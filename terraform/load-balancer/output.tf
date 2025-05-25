output "frontend_target_group" {
  value = aws_lb_target_group.frontend_tg.arn
}
output "backend_target_group" {
  value = aws_lb_target_group.backend_tg.arn
}

output "internal_lb_url" {
  value = aws_lb.backend_lb.dns_name
}


output "external_lb_url" {
  value = aws_lb.frontend_lb.dns_name
}