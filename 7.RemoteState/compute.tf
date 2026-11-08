data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "instance" {
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  subnet_id = data.terraform_remote_state.base_infra.outputs.public_subnet_id

  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.micro"

  tags = {
    Terraform = var.terraform
    Project   = var.aws_region
  }
}