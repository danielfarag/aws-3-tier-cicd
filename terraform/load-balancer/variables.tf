variable "vpc" {
  type = string
}

variable "frontend_lb_sg" {
  type = string
}

variable "backend_lb_sg" {
  type = string
}


variable "private_subnets" {
  type = list(string)
}


variable "public_subnets" {
  type = list(string)
}