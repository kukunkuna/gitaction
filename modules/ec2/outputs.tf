output "id" {
  description = "The ID of the instance"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IP (if assigned)"
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "Private IP address"
  value       = aws_instance.this.private_ip
}
