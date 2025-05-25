resource "aws_ssm_parameter" "db_username_ssm" {
  name        = "/three_tier/rds/username"
  description = "RDS DB username"
  type        = "SecureString"
  value       = var.username  
}

resource "aws_ssm_parameter" "db_password_ssm" {
  name        = "/three_tier/rds/password"
  description = "RDS DB password"
  type        = "SecureString"
  value       = var.password
}

resource "aws_ssm_parameter" "db_host_ssm" {
  name        = "/three_tier/rds/host"
  description = "RDS DB host endpoint"
  type        = "String"
  value       = aws_db_instance.default.address
}

resource "aws_ssm_parameter" "db_name_ssm" {
  name        = "/three_tier/rds/db_name"
  description = "RDS DB Name"
  type        = "String"
  value       = var.db_name
}

resource "aws_ssm_parameter" "db_port_ssm" {
  name        = "/three_tier/rds/port"
  description = "RDS DB port"
  type        = "String"
  value       = aws_db_instance.default.port
}