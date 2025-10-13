resource "aws_instance" "ec2_server" {
  ami           = "ami-052064a798f08f0d3
  instance_type = "t2.micro"
  tags = {
    Name = "gitacution"
  }
}
