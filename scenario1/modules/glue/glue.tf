resource "aws_glue_job" "data_quality_job" {
  name     = var.job_name
  role_arn = aws_iam_role.glue_role.arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.script_s3_bucket}/main.py"
    python_version  = "3.9"
  }
}

resource "aws_iam_role" "glue_role" {
  name = "${var.job_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "glue_policy" {
  name   = "${var.job_name}_policy"
  policy = data.aws_iam_policy_document.glue_policy_doc.json
}

data "aws_iam_policy_document" "glue_policy_doc" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket",
    ]
    resources = [
      "${var.data_source_bucket_arn}/*",
      "${var.data_source_bucket_arn}",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:::/aws-glue/*"]
  }
}

resource "aws_iam_role_policy_attachment" "glue_policy_attach" {
  role       = aws_iam_role.glue_role.name
  policy_arn = aws_iam_policy.glue_policy.arn
}