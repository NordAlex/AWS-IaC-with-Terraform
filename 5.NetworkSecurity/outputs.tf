output "ssh_security_group_id" {
  description = "SSH security group ID"
  value       = aws_security_group.ssh_security_group.id
}

output "public_http_security_group_id" {
  description = "Public HTTP security group ID"
  value       = aws_security_group.public_security_group.id
}

output "private_http_security_group_id" {
  description = "Private HTTP security group ID"
  value       = aws_security_group.private_security_group.id
}