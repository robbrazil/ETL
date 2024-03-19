resource "aws_lambda_function" "lambda" {
  depends_on    = [aws_s3_object.lambda-package]
  description   = var.lambda_description
  s3_bucket     = aws_s3_bucket.lambda-bucket.bucket
  s3_key        = "test_function.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda.arn
  handler       = "main.handler"
  runtime       = "python3.11"
  memory_size   = 128
  timeout       = 60

  source_code_hash = data.archive_file.function_zip.output_base64sha256
}

