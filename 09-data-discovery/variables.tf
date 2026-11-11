variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "project_id" {
  description = "Project tag for resources."
  type        = string
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
}

variable "public_subnet_name" {
  description = "Public subnet name."
  type        = string
}

variable "security_group_name" {
  description = "Security group name."
  type        = string
}
