resource "aws_s3_bucket" "demo_bucket" {
    bucket = "pmshrik-bucket-01"
    force_destroy = true

    tags = {
      Name = "S3_bucket_demo"
    }
  
}