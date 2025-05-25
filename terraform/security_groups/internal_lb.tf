resource "aws_security_group" "internal_lb_sg" {
  name   = "internal-lb-sg"
  vpc_id = var.vpc

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}