variable "image_ami" {
  type = string
}

variable "image_type" {
  type = string
  default = "t3.small"
}


variable "frontend_sg" {
  type = string
}

variable "backend_sg" {
  type = string
}


variable "private_subnets" {
  type = list(string)
}


variable "public_subnets" {
  type = list(string)
}


variable "backend_tg_arn" {
  type = string
}

variable "frontend_tg_arn" {
  type = string
}
