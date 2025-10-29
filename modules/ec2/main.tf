// Lookup Amazon Linux 2 if AMI is not provided
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_security_group" "this" {
  count       = var.vpc_id == null ? 0 : 1
  name        = "${var.name}-sg"
  description = "Security group for ${var.name} instances"
  vpc_id      = var.vpc_id

  # Create ingress rules only for the provided CIDRs. If none are provided,
  # no SSH ingress rule will be created (useful when using SSM-only access).
  dynamic "ingress" {
    for_each = var.allowed_ssh_cidrs
    content {
      description = "SSH from ${ingress.value}"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  # Keep egress open by default to allow outbound connectivity; restrict if
  # your security posture requires it.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.name}-sg" })
}

resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami != null ? var.ami : data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  associate_public_ip_address = var.assign_public_ip

  # Attach module-created SG plus any provided SGs
  vpc_security_group_ids = concat(var.vpc_security_group_ids, length(aws_security_group.this) > 0 ? [aws_security_group.this[0].id] : [])

  key_name = var.key_name != null ? var.key_name : null

  root_block_device {
    volume_size = var.ebs_root_volume_size
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = var.kms_key_arn
  }
  # Attach instance profile if the module created one for SSM
  iam_instance_profile = var.iam_instance_profile_name

  tags = merge(var.tags, { Name = "${var.name}-${count.index + 1}" })
}

# IAM role & instance profile for SSM (created only when enable_ssm = true)
resource "aws_iam_role" "ssm_role" {
  count = var.enable_ssm ? 1 : 0

  name = "${var.name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  count      = var.enable_ssm ? 1 : 0
  role       = aws_iam_role.ssm_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "this" {
  count = var.enable_ssm ? 1 : 0
  name  = "${var.name}-ssm-instance-profile"
  role  = aws_iam_role.ssm_role[0].name
}
