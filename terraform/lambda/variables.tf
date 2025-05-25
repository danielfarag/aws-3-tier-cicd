variable "region" {
  type        = string
}

variable "github_organization" {
  type        = string
  default     = "danielfarag" 
}

variable "github_repository" {
  type        = string
  default     = "aws-3-tier-cicd" 
}

variable "github_branch" {
  type        = string
  default     = "main" 
}
