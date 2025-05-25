variable "region" {
  type = string
  default="us-east-1"
}

variable "availability_zones" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}