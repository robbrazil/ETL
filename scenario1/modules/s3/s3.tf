resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count  = var.create_lambda_trigger ? 1 : 0
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = var.lambda_trigger_arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_bucket_acl" "bucket_acl" {

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"

  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.bucket]
}