variable "schedule_expression" {
  type = string
}

variable "event_bridge_name" {
  type = string
}

variable "lambda_weather_retrieve" {
  type = object({
    name        = string,
    description = string
  })
}

variable "lambda_weather_etl" {
  type = object({
    name        = string,
    description = string
  })
}

variable "s3_landing" {
  type = object({
    name = string
  })
}

variable "s3_transformed" {
  type = object({
    name = string
  })
}

variable "env" {
  type = string
}

variable "job_name" {
  type = string
}

variable "state_bucket" {
  type    = string
  default = "testrob12345"
}