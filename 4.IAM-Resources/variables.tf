variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "project_tag" {
  description = "Project tag."
  type        = string
}

variable "iam_group_name" {
  description = "Provides custom IAM group name."
  type        = string
}

variable "iam_role_name" {
  description = "Provides custom IAM role name."
  type        = string
}

variable "iam_profile_name" {
  description = "Provides custom IAM profile name."
  type        = string
}

variable "iam_policy_name" {
  description = "Provides custom IAM policy name."
  type        = string
}