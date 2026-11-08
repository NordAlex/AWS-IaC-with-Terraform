variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "project" {
  description = "Project tag for resources."
  type        = string
}

variable "terraform" {
  description = "Terrfaform tag."
  type        = bool
}

variable "state_bucket" {
  description = "S3 bucket name that stores the remote state."
  type        = string
}

variable "state_key" {
  description = "S3 key path to the remote state file."
  type        = string
}

