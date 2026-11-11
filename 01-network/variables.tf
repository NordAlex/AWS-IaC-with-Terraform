variable "aws_region" {
  description = "AWS region where the VPC resources will be deployed."
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
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
