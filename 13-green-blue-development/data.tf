data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = ["${var.name_prefix}-vpc"]
  }
}

data "aws_subnet" "public1" {
  filter {
    name   = "tag:Name"
    values = ["${var.name_prefix}-public-subnet1"]
  }
}

data "aws_subnet" "public2" {
  filter {
    name   = "tag:Name"
    values = ["${var.name_prefix}-public-subnet2"]
  }
}

data "aws_security_group" "ssh" {
  name = "${var.name_prefix}-sg-ssh"
}

data "aws_security_group" "http" {
  name = "${var.name_prefix}-sg-http"
}

data "aws_security_group" "lb" {
  name = "${var.name_prefix}-sg-lb"
}

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
