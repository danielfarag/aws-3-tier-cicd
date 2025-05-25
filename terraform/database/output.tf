output "db_connection_string" {
  value = "mysql://${var.username}:${var.password}@${aws_db_instance.default.endpoint}:${aws_db_instance.default.port}/${var.db_name}"
  sensitive = true
}

output "db_host" {
  value = aws_db_instance.default.endpoint
}

output "db_user" {
  value = var.username
}

output "db_password" {
  value = var.password
}

output "db_port" {
  value = aws_db_instance.default.port
}

output "db_name" {
  value = var.db_name
}