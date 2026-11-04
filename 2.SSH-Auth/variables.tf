variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC."
  type        = string
}

variable "project_tag" {
  description = "Project tag."
  type        = string
}

variable "id_tag" {
  description = "ID tag."
  type        = string
}

variable "ssh_key" {
  description = "Provides custom public SSH key."
  type        = string
}

variable "ssh_ec2_key_pair_name" {
  description = "Keypair name."
  type        = string
}

variable "ec2_name" {
  description = "Name tag for the EC2."
  type        = string
}