resource "aws_launch_template" "frontend" {
  name_prefix   = "frontend"
  image_id      = var.image_ami
  instance_type = var.image_type

  user_data = filebase64("${path.module}/frontend.sh")
  
  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true 
    device_index                = 0    
    security_groups             = [ var.frontend_sg ] 
    subnet_id                   = element(var.public_subnets, 0)
  }
}


resource "aws_launch_template" "backend" {
  name_prefix   = "backend"
  image_id      = var.image_ami
  instance_type = var.image_type

  user_data = filebase64("${path.module}/backend.sh")

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_instance_profile.name
  }

  network_interfaces {
    associate_public_ip_address = true 
    device_index                = 0    
    security_groups             = [ var.backend_sg ] 
    subnet_id                   = element(var.private_subnets, 0)
  }
}
