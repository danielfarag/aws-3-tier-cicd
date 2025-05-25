resource "aws_autoscaling_group" "backend" {
  name_prefix          = "backend-sg"
  min_size            = 1
  max_size            = 1 #3
  desired_capacity    = 1 #2
  vpc_zone_identifier = var.private_subnets
  target_group_arns   = [var.backend_tg_arn ]

  health_check_type         = "ELB"
  health_check_grace_period = 10

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }



  tag {
    key                 = "Name"
    value               = "Backend"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "frontend" {
  name_prefix          = "frontend-sg"
  min_size            = 1
  max_size            = 1 #3
  desired_capacity    = 1 #2
  vpc_zone_identifier = var.public_subnets
  target_group_arns   = [var.frontend_tg_arn ]
  
  health_check_type         = "ELB"
  health_check_grace_period = 10

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Frontend"
    propagate_at_launch = true
  }
}