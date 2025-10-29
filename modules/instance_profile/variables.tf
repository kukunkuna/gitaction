variable "role_name" {
  description = "Name of the IAM role to create"
  type        = string
  default     = "ec2-ssm-role"
}

variable "tags" {
  description = "Tags to apply to the IAM role and instance profile"
  type        = map(string)
  default     = {}
}