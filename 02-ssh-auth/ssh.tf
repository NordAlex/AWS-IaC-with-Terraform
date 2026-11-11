resource "aws_key_pair" "ec2_key" {
  key_name   = var.ssh_ec2_key_pair_name
  public_key = var.ssh_key
  tags = {
    "Name"    = var.ssh_ec2_key_pair_name
    "Project" = var.project_tag
    "ID"      = var.id_tag
  }
}