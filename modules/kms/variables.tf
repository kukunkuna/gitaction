variable "key_alias" {
  description = "Alias for the KMS key"
  type        = string
}

variable "key_description" {
  description = "Description for the KMS key"
  type        = string
  default     = "Key for EC2 instances"
}

variable "key_policy" {
  description = "IAM policy for the KMS key"
  type        = string
  default     = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOT
}

variable "deletion_window_in_days" {
  description = "Number of days before the KMS key is deleted after scheduling deletion"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags to apply to the KMS key and alias"
  type        = map(string)
  default     = {}
}
