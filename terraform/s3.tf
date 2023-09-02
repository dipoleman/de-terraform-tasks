resource "aws_s3_bucket" "code_bucket" {
  bucket_prefix = "nc-jm-de-code-"
  tags = {
    Name = "de-terraform-tasks"
  }
}

resource "aws_s3_bucket" "data_bucket" {
  bucket_prefix = "nc-jm-de-data-"
  tags = {
    Name = "de-terraform-tasks"
  }
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "s3_file_reader/s3_file_reader.zip"
  source = "${path.module}/../src/file_reader/s3_file_reader.zip"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.data_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_file_reader.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}