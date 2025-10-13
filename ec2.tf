resource "aws_instance" "my_ec2" {
  ami           = "ami-052064a798f08f0d3"
  instance_type = "t2_micro"
  availability_zone = "subnet-0ee2647685f6e2b5d"
tags = {
    Name = "MyEC2Instance"
  }
}