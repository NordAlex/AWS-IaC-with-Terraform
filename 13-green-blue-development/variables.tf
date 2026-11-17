variable "name_prefix" {
  description = "Prefix for AWS resource names"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "blue_weight" {
  description = "Traffic weight for Blue environment"
  type        = number
}

variable "green_weight" {
  description = "Traffic weight for Green environment"
  type        = number
}

variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}
