
resource "aws_lb" "backend_lb" {
  name               = "backend-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.backend_lb_sg]
  subnets            = var.private_subnets

  tags = {
    Name = "backend-lb"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-tg"
  port     = 3000 
  protocol = "HTTP"
  vpc_id   = var.vpc

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 15
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }
}

resource "aws_lb_listener" "backend_ls" {
  load_balancer_arn = aws_lb.backend_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}


resource "aws_ssm_parameter" "internal_lb" {
  name        = "/three_tier/lb/internal_lb"
  description = "Defined Internal Loadbalancer"
  type        = "String"
  value       = aws_lb.backend_lb.dns_name  
}
