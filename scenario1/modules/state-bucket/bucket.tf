resource "aws_s3_bucket" "state" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "state" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = var.bucket_name

  versioning_configuration {
    status = "Enabled"
  }
}
