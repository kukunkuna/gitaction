module "instance_profile" {
  source    = "../../modules/instance_profile"
  role_name = "my-ec2-ssm-role"
  tags = {
    Environment = "demo"
    Project     = "example"
  }
}