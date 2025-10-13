# Specify the provider


# Create an S3 bucket
resource "aws_s3_bucket" "gitauction" {
  bucket = "gitauction"  # must be globally unique
  acl    = "private"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}
