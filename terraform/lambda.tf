
# This uploads the zipped lambda function to AWS Lambda

resource "aws_lambda_function" "s3_file_reader" {
  filename      = "../src/file_reader/s3_file_reader.zip"
  # function_name: The name of the Lambda function.
  function_name = "s3-file-reader"
  # role: The Amazon Resource Name (ARN) of the IAM role that Lambda assumes when it executes your function.
  role          = aws_iam_role.lambda_role.arn
  # handler: The function that Lambda calls to begin execution.
  handler       = "reader.lambda_handler"
  runtime       = "python3.8"
  tags = {
    Name = "de-terraform-tasks"
  }
}

resource "aws_lambda_permission" "allow_s3" {
  # action: The AWS Lambda action you want to allow in this statement. In this case, it is set to "lambda:InvokeFunction", which allows the specified principal to invoke the function.
  action         = "lambda:InvokeFunction"
  # function_name: The name of the Lambda function that you want to grant permission to. In this case, it is set to the function_name attribute of the aws_lambda_function.s3_file_reader resource.
  function_name  = aws_lambda_function.s3_file_reader.function_name
  # principal: The AWS service principal that you want to grant permission to. In this case, it is set to "s3.amazonaws.com", which represents the Amazon S3 service.
  principal      = "s3.amazonaws.com"
  # source_arn: The Amazon Resource Name (ARN) of the source entity that is invoking the function. In this case, it is set to the arn attribute of the aws_s3_bucket.data_bucket resource.
  source_arn     = aws_s3_bucket.data_bucket.arn
  # source_account: The AWS account ID of the source entity that is invoking the function. In this case, it is set to the account_id attribute of the data.aws_caller_identity.current data source.
  source_account = data.aws_caller_identity.current.account_id
}


