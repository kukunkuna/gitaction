#module "ec2_my_instance" {
#  source        = "./modules/ec2"
#  ami           = "ami-052064a798f08f0d3"
#  instance_type = "t2.micro"
#  subnet_id     = "subnet-0ee2647685f6e2b5d"
#  vpc_security_group_ids= ["sg-0a5f66b2c030f2fd1"]
#  tags = {
#    Name = "MyEC2Instance"
#  }
#}
