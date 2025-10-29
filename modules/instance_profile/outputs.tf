output "instance_profile_name" {
  description = "Name of the instance profile"
  value       = aws_iam_instance_profile.this.name
}

output "instance_profile_arn" {
  description = "ARN of the instance profile"
  value       = aws_iam_instance_profile.this.arn
}