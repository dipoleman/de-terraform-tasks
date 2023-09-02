resource "aws_s3_bucket" "demo_bucket" {
  bucket_prefix = "first-bucket-"
  tags = {
    project = "dands"
  }
}

resource "aws_s3_object" "demo_object" {
  bucket = aws_s3_bucket.demo_bucket.bucket
  key = "test_file.txt"
  source = "./test_file.txt"
}