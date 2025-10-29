module "ec2_my_instance" {
  source                 = "./modules/ec2"
  name                   = "my-ec2"
  # optional: explicit AMI (if omitted, module looks up latest Amazon Linux 2)
  ami                    = "ami-052064a798f08f0d3"
  instance_type          = "t3.micro"
  instance_count         = 1
  subnet_id              = "subnet-0ee2647685f6e2b5d"
  # optional: provide the VPC id if you want the module to create a SG
  vpc_id                 = ""
  vpc_security_group_ids = ["sg-0a5f66b2c030f2fd1"]
  # Security: prefer SSM instead of opening SSH. If you want SSH,
  # provide a narrow list of CIDRs below. Leave empty to disable SSH.
  allowed_ssh_cidrs = []
  enable_ssm        = true
  assign_public_ip     = false
  key_name             = null
  ebs_root_volume_size = 8
  tags = {
    Name = "MyEC2Instance"
    Environment = "demo"
  }
}
