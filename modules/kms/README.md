# KMS Module

This module creates a KMS key and an alias for use with EC2 instances or other AWS resources.

## Inputs

- `key_alias` - Alias for the KMS key (required)
- `key_description` - Description for the KMS key (default: "Key for EC2 instances")
- `key_policy` - IAM policy for the KMS key (default: allows all actions for all principals; customize for production)

## Updated Inputs

- `deletion_window_in_days` - Number of days before the KMS key is deleted after scheduling deletion (default: 30)
- `tags` - Tags to apply to the KMS key and alias (default: `{}`)

## Outputs

- `key_id` - The ID of the KMS key
- `key_arn` - The ARN of the KMS key
- `alias_name` - The alias name of the KMS key

## Best Practices

- Use a restrictive key policy to limit access to specific IAM principals.
- Apply tags to all resources for better management and cost tracking.

## Usage

See the example in `examples/kms/usage.tf` for how to use this module.