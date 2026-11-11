output "instance_id" {
  description = "EC2 instance of the created instance."
  value       = aws_instance.instance.id
}
