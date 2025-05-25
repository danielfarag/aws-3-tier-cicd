resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-rds-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name = "MyRDSDBSubnetGroup"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
 
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  publicly_accessible  = false
  skip_final_snapshot  = var.skip_final_snapshot

  db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name

  vpc_security_group_ids = [var.db_sg]

  tags = {
    Name = "mysql"
  }
}
