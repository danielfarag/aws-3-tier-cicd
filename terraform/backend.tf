terraform {
  backend "s3" {
    bucket = "aws-3-tier-iti"
    key = "app-state"
    region = "us-east-1"
  }
}