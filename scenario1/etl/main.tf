locals {
  lambda_weather_retrieve_custom_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${module.s3_landing.name}/*"
      }
    ]
  })

  lambda_weather_etl_custom_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "arn:aws:s3:::${module.s3_transformed.name}/*"
      }
    ]
  })
}

module "eventbridge" {
  source               = "../modules/eventbridge"
  schedule_expression  = var.schedule_expression
  event_bridge_name    = var.event_bridge_name
  lambda_function_name = module.lambda_weather_retrieve.name
  target = {
    arn = module.lambda_weather_retrieve.arn
  }
}

module "lambda_weather_retrieve" {
  source               = "../modules/lambda"
  function_name        = var.lambda_weather_retrieve.name
  env                  = var.env
  create_custom_policy = true
  custom_policy_json   = local.lambda_weather_retrieve_custom_policy
  lambda_description   = var.lambda_weather_retrieve.description
}

module "lambda_weather_etl" {
  source               = "../modules/lambda"
  function_name        = var.lambda_weather_etl.name
  env                  = var.env
  create_custom_policy = true
  custom_policy_json   = local.lambda_weather_etl_custom_policy
  lambda_description   = var.lambda_weather_etl.description
}

module "s3_landing" {
  source                = "../modules/s3"
  bucket_name           = var.s3_landing.name
  create_lambda_trigger = true
  lambda_trigger_arn    = module.lambda_weather_etl.arn
}

module "s3_transformed" {
  source                = "../modules/s3"
  bucket_name           = var.s3_transformed.name
  create_lambda_trigger = false
}

module "s3_glue" {
  source                = "../modules/s3"
  bucket_name           = var.s3_transformed.name
  create_lambda_trigger = false
}

module "glue" {
  source                 = "../modules/glue"
  script_s3_bucket       = module.s3_glue.name
  job_name               = var.job_name
  data_source_bucket_arn = module.s3_glue.arn
}