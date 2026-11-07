variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "project_tag" {
  description = "Project tag."
  type        = string
}

variable "allowed_ip_range" {
  description = "Allowed IP range."
  type        = list(string)
}

variable "ssh_security_group_name" {
  description = "SSH security group name."
  type        = string
}

variable "public_security_group_name" {
  description = "Public security group name."
  type        = string
}

variable "private_security_group_name" {
  description = "Private security group name."
  type        = string
}

variable "private_instance_id" {
  description = "Private EC2 instance ID."
  type        = string
}

variable "public_instance_id" {
  description = "Public EC2 instance ID."
  type        = string
}

variable "vpc_name" {
  description = "VPC name."
  type        = string
}