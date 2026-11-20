variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "launch_template_name" {
  description = "Launch Template name."
  type        = string
}

variable "ami_name" {
  description = "AMI name."
  type        = string
}

variable "ssh_instance_secirity_group_id" {
  description = "Security group for ssh instance id."
  type        = string
}

variable "http_instance_secirity_group_id" {
  description = "Security group for http instance id."
  type        = string
}

variable "lb_http_security_group_id" {
  description = "Security group for lb."
  type        = string
}

variable "aws_asg_name" {
  description = "Auto scaling group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "load_balancer_name" {
  description = "Load balancer name."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ids."
  type        = list(string)
}