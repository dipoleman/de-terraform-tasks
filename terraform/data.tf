data "aws_caller_identity" "current" {}

data "aws_region" "current" {
  name = "eu-west-2"
}

# This is so that we can create a zip file automattically for the lambda function in case we change the function. It ensures that when the lambda.ft file is called the correct zip is loaded into the s3 bucket
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../src/file_reader/reader.py"
  output_path = "${path.module}/../function.zip"
}
