# Instance Profile Module

This module creates an IAM role, attaches the AmazonSSMManagedInstanceCore policy, and creates an instance profile for EC2 instances to access SSM.

## Inputs

- `role_name` - Name of the IAM role to create (default: `ec2-ssm-role`)
- `tags` - Tags to apply to the IAM role and instance profile (default: `{}`)

## Outputs

- `instance_profile_name` - Name of the instance profile
- `instance_profile_arn` - ARN of the instance profile

## Usage

See the example in `examples/instance_profile/usage.tf` for how to use this module.