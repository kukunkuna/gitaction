module "kms_key" {
  source          = "../../modules/kms"
  key_alias       = "ec2-key"
  key_description = "KMS key for encrypting EC2 instance volumes"

  # Optional: customize the key policy for your environment
  key_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOT
}