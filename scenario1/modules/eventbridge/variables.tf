variable "event_bridge_name" {
  type = string
}

variable "schedule_expression" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "target" {
  type = object({
    arn = string
  })
}