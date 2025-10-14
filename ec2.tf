module "ec2_my_instance" {
  source        = "./modules/ec2"
  ami           = "ami-052064a798f08f0d3"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0ee2647685f6e2b5d"
  tags = {
    Name = "MyEC2Instance"
  }
}
