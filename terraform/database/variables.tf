variable "allocated_storage"{
  type = number
  default=10
}
variable "db_name"{
  type = string
  default="mydb"
}
variable "engine"{
  type = string
  default="mysql"
}
variable "engine_version"{
  type = string
  default="8.0"
}
variable "instance_class"{
  type = string
  default="db.t3.micro"
}
variable "username"{
  type = string
  default="foo"
}
variable "password"{
  type = string
  default="foobarbaz"
}
variable "parameter_group_name"{
  type = string
  default="default.mysql8.0"
}
variable "skip_final_snapshot"{
  type = bool
  default=true
}

variable "db_sg" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}