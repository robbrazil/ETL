resource "aws_iam_role" "lambda" {
  name = "${var.function_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "custom_lambda_policy" {
  count  = var.create_custom_policy ? 1 : 0
  name   = "${var.function_name}-custom-policy"
  policy = var.custom_policy_json
}

data "aws_iam_policy_document" "s3_get_object_policy" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.lambda-bucket.bucket}/*",
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "get-s3-policy-${aws_lambda_function.lambda.function_name}"
  policy = data.aws_iam_policy_document.s3_get_object_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_iam_role_policy_attachment" "custom_lambda_policy_attach" {
  count      = var.create_custom_policy ? 1 : 0
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.custom_lambda_policy[0].arn
}