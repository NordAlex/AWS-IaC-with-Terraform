output "iam_group_name" {
  description = "Name of the IAM group"
  value       = aws_iam_group.group.name
}

output "iam_policy_arn" {
  description = "ARN of the custom IAM policy"
  value       = aws_iam_policy.policy.arn
}

output "iam_role_name" {
  description = "Name of the IAM role"
  value       = aws_iam_role.role.name
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.role.arn
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile"
  value       = aws_iam_instance_profile.instance.name
}