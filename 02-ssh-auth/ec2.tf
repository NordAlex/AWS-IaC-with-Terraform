data "aws_vpc" "existing" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public" {
  vpc_id            = data.aws_vpc.existing.id
  availability_zone = "us-east-1a"

  filter {
    name   = "tag:Name"
    values = ["cmtr-sfj054j4-public_subnet"]
  }
}

data "aws_security_group" "security_group" {
  vpc_id = data.aws_vpc.existing.id

  filter {
    name   = "tag:Name"
    values = ["cmtr-sfj054j4-sg"]
  }
}

resource "aws_instance" "web" {
  ami             = "ami-0c230065b91270bc6"
  instance_type   = "t3.micro"
  security_groups = [data.aws_security_group.security_group.id]

  subnet_id = data.aws_subnet.public.id

  key_name = aws_key_pair.ec2_key.key_name

  tags = {
    "Name"    = var.ec2_name
    "Project" = var.project_tag
    "ID"      = var.id_tag
  }
}