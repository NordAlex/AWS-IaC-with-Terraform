#SSH Security Group
resource "aws_security_group" "ssh_security_group" {
  name   = var.ssh_security_group_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh_security_group.id

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = var.allowed_ip_range
}

resource "aws_security_group_rule" "ssh_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.ssh_security_group.id

  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = var.allowed_ip_range
}

#Public security group
resource "aws_security_group" "public_security_group" {
  name   = var.public_security_group_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "public_http_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.public_security_group.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = var.allowed_ip_range
}

resource "aws_security_group_rule" "public_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.public_security_group.id

  from_port   = -1
  to_port     = -1
  protocol    = "icmp"
  cidr_blocks = var.allowed_ip_range
}

#Private security group
resource "aws_security_group" "private_security_group" {
  name   = var.private_security_group_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "private_http_ingress" {
  type              = "ingress"
  security_group_id = aws_security_group.private_security_group.id

  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_security_group.id
}

resource "aws_security_group_rule" "private_icmp" {
  type              = "ingress"
  security_group_id = aws_security_group.private_security_group.id

  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_security_group.id
}
