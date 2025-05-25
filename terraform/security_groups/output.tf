output "frontend_sg" {
  value=aws_security_group.frontend.id
}

output "backend_sg" {
  value=aws_security_group.backend.id
}

output "database_sg" {
  value=aws_security_group.database.id
}


output "frontend_lb_sg" {
  value=aws_security_group.external_lb_sg.id
}

output "backend_lb_sg" {
  value=aws_security_group.internal_lb_sg.id
}
