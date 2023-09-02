resource "aws_lambda_function" "demo_lambda" {
  filename      = "demo.zip"
  function_name = "demo_lambda"
  role          = aws_iam_role.iam_for_demo_lambda.arn
  handler       = "demo.handler"
  runtime       = "python3.8"
}


resource "aws_iam_role" "iam_for_demo_lambda" {
  name = "iam_for_demo_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_cloudwatch_log_group" "example" {
  name = "demo_lambda_log_group"
}

resource "aws_iam_policy" "demo_lambda_logging_policy" {
  name = "demo_lambda_logging_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "demo_lambda_logging_policy_attachment" {
  role       = aws_iam_role.iam_for_demo_lambda.id
  policy_arn = aws_iam_policy.demo_lambda_logging_policy.arn
}
