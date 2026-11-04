output "ec2_public_ip" {
  description = "Public IP address of EC2"
  value       = aws_instance.web.public_ip
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "ec2_public_dns" {
  description = "Public DNS name of EC2"
  value       = aws_instance.web.public_dns
}

output "ssh_command" {
  description = "SSH connection command"
  value       = "ssh -i ~/.ssh/terraform-ec2 ec2-user@${aws_instance.web.public_ip}"
}