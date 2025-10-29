output "instance_ids" {
  description = "IDs of created instances"
  value       = aws_instance.this[*].id
}

output "public_ips" {
  description = "Public IPs of instances (if assigned)"
  value       = aws_instance.this[*].public_ip
}

output "private_ips" {
  description = "Private IPs of instances"
  value       = aws_instance.this[*].private_ip
}

output "security_group_id" {
  description = "ID of module-created security group (if created)"
  value       = length(aws_security_group.this) > 0 ? aws_security_group.this[0].id : null
}

output "iam_instance_profile_name" {
  description = "Instance profile name created for SSM (if enable_ssm = true)"
  value       = length(aws_iam_instance_profile.this) > 0 ? aws_iam_instance_profile.this[0].name : null
}

output "kms_key_arn" {
  description = "ARN of the KMS key used for encrypting the root volume"
  value       = var.kms_key_arn
}
