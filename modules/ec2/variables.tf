variable "name" {
  description = "Name prefix for resources (used for tags and naming)"
  type        = string
  default     = "ec2"
}

variable "ami" {
  description = "Optional AMI id. If null, the module will lookup the latest Amazon Linux 2 AMI."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}

variable "vpc_id" {
  description = "VPC id (used for security group). Optional but recommended." 
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of existing security group ids to attach to the instance in addition to the module-created SG"
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the instance"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Optional key pair name for SSH access (null = none)"
  type        = string
  default     = null
}

variable "allowed_ssh_cidrs" {
  description = "List of CIDR blocks allowed to SSH to the instance. Leave empty to disable SSH access. For production, provide narrow CIDRs."
  type        = list(string)
  default     = []
}

variable "enable_ssm" {
  description = "Whether to enable AWS Systems Manager (SSM) Session Manager access. When true, the module will create an IAM role and instance profile and attach the AmazonSSMManagedInstanceCore policy. This allows access without opening SSH."
  type        = bool
  default     = false
}

variable "ebs_root_volume_size" {
  description = "Root EBS volume size (GiB)"
  type        = number
  default     = 8
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "ARN of the KMS key to use for encrypting the root volume. This is now mandatory."
  type        = string
}
