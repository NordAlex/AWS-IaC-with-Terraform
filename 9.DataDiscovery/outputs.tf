output "amazon_linux_ami_id" {
  value = data.aws_ami.amazon_linux_2023.id
}

output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance, if assigned"
  value       = aws_instance.web.public_ip
}

output "vpc_id" {
  description = "ID of the discovered VPC"
  value       = data.aws_vpc.vpc.id
}

output "subnet_id" {
  description = "ID of the discovered public subnet"
  value       = data.aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the discovered security group"
  value       = data.aws_security_group.instance_sg.id
}