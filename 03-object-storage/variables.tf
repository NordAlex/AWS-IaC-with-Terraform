variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "project_tag" {
  description = "Project tag."
  type        = string
}

variable "bucket_name" {
  description = "Provides custom public SSH key."
  type        = string
}