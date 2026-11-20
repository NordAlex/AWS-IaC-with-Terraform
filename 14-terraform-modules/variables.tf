variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Three distinct availability zones for public subnets."
  type        = list(string)
}

variable "public_subnet_names" {
  description = "Name tags for the three public subnets, ordered by availability zone."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "IPv4 CIDR blocks for the three public subnets, ordered by availability zone."
  type        = list(string)
}

variable "internet_gateway_name" {
  description = "Name tag for the Internet Gateway."
  type        = string
}

variable "routing_table_name" {
  description = "Name tag for the shared public route table."
  type        = string
}


#security 
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

#app

variable "launch_template_name" {
  description = "Launch Template name."
  type        = string
}

variable "ami_name" {
  description = "AMI name."
  type        = string
}

variable "iam_instance_name" {
  description = "Iam instance name."
  type        = string
}

variable "aws_asg_name" {
  description = "Auto scaling group."
  type        = string
}

variable "load_balancer_name" {
  description = "Load balancer name."
  type        = string
}