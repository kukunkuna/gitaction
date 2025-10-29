# EC2 module


This module creates one or more EC2 instances and a security group (if `vpc_id` is provided). It looks up the latest Amazon Linux 2 AMI by default but accepts an explicit `ami` if you want to pin a different image.

Security best-practices included in this module:

- Do not open SSH by default. The module now expects a list of `allowed_ssh_cidrs` (empty by default). If you want SSH access, provide one or more CIDRs. Leaving the list empty disables SSH ingress.
- Provide SSM access instead of SSH. Enable `enable_ssm = true` to create an IAM role and instance profile with the `AmazonSSMManagedInstanceCore` policy. Use SSM Session Manager to access instances without a public SSH port.
- Avoid wide CIDR blocks for SSH; prefer single IPs or narrow office ranges (for example: `203.0.113.4/32`).

Best-practice notes:
- Parameterize everything that may vary between environments (AMI, instance_type, subnets, security groups).
- Keep examples in the `examples/` folder to avoid accidental application.



Inputs

- `name` - name prefix used for tagging
- `ami` - optional AMI id (default: latest Amazon Linux 2)
- `instance_type` - instance type
- `instance_count` - number of instances
- `subnet_id` - target subnet id (required)
- `vpc_id` - VPC id used to create a security group (optional)
- `vpc_security_group_ids` - list of existing SG ids to attach (in addition to the module SG)
- `assign_public_ip` - whether to assign a public IP
- `key_name` - optional keypair name
- `allowed_ssh_cidrs` - list of CIDR blocks allowed to SSH; leave empty to disable SSH
- `enable_ssm` - whether to create an IAM role and instance profile and enable SSM (recommended instead of opening SSH)
- `ebs_root_volume_size` - root EBS size in GiB
- `tags` - map of tags applied to resources

Outputs

- `instance_ids`, `public_ips`, `private_ips`, `security_group_id`

Usage example is available in `examples/ec2/usage.tf`.
