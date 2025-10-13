# Specify the provider
provider "aws" {
  region = "us-east-1"  # change to your desired region
}

# Create an S3 bucket
resource "aws_s3_bucket" "gitauction" {
  bucket = "gitauction"  # must be globally unique
  acl    = "private"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}
