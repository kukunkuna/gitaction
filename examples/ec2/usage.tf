/*
  Example (kept in examples/ to avoid accidental application by default):

  To try this example, cd into the repo root and run:
    terraform init
    terraform plan -var 'subnet_id=subnet-xxxx' -var 'vpc_id=vpc-xxxx' -var 'ssh_cidr=1.2.3.4/32'

  Adjust values and then run `terraform apply` when ready.
*/

module "example_ec2" {
  source  = "../modules/ec2"
  name    = "example-ec2"
  subnet_id = "subnet-REPLACE_ME"
  vpc_id    = "vpc-REPLACE_ME"
  instance_type = "t3.micro"
  instance_count = 1
  assign_public_ip = true
  # Prefer SSM for access; if you want SSH, provide a narrow CIDR in allowed_ssh_cidrs
  # Example: allowed_ssh_cidrs = ["203.0.113.4/32"]
  allowed_ssh_cidrs = []
  # To enable SSM (recommended), set enable_ssm = true and do NOT provide SSH CIDRs
  enable_ssm = true
  tags = {
    Environment = "demo"
  }
  kms_key_arn = module.kms_key.key_arn
}
