data "aws_ssm_parameter" "amazon_linux_2023" {
  name = var.ami_name
}

resource "aws_instance" "instance" {
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  subnet_id = data.terraform_remote_state.base_infra.outputs.public_subnet_id

  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro"

  tags = {
    Terraform = var.terraform
    Project   = var.project
  }
}