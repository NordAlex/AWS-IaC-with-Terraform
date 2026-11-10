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

variable "key_pair_name" {
  description = "Key pair name."
  type        = string
}

variable "iam_instance_name" {
  description = "Iam instance name."
  type        = string
}

variable "ssh_instance_secirity_group_name" {
  description = "Security group for ssh instance name."
  type        = string
}

variable "http_instance_secirity_group_name" {
  description = "Security group for http instance name."
  type        = string
}

variable "aws_asg_name" {
  description = "Auto scaling group."
  type        = string
}

variable "vpc_id" {
  description = "VPC id."
  type        = string
}

variable "load_balancer_name" {
  description = "Load balancer name."
  type        = string
}