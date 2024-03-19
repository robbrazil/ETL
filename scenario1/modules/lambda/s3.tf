resource "aws_s3_bucket" "lambda-bucket" {
  bucket = "${var.env}-${var.function_name}-bucket"
}

resource "aws_s3_bucket_public_access_block" "lambda-acl" {
  bucket = aws_s3_bucket.lambda-bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "lambda-package" {
  depends_on = [data.archive_file.function_zip]

  bucket      = aws_s3_bucket.lambda-bucket.bucket
  key         = "test_function.zip"
  source      = "${path.module}/lambda/test_function.zip"
  source_hash = data.archive_file.function_zip.output_md5
}

resource "aws_s3_bucket_versioning" "lambda-bucket-versioning" {
  bucket = aws_s3_bucket.lambda-bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "archive_file" "function_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda/test_function.zip"
  source_file = "${path.module}/lambda/main.py"
}
