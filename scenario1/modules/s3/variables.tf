variable "bucket_name" {
  type = string
}

variable "create_lambda_trigger" {
  type = bool
}

variable "lambda_trigger_arn" {
  type    = string
  default = null
}