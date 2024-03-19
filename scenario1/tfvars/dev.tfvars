env                    = "dev"
function_name          = "etl_dev"
policy_json            = "etl_policy"
etl_lambda_description = "Lambda to extract data"
schedule_expression    = "cron(0 5 ? * MON-FRI *)"
event_bridge_name      = "weather_trigger"
lambda_weather_retrieve = {
  name        = "weather_retrieve",
  description = "lambda retrieve"
}
lambda_weather_etl = {
  name        = "weather_etl",
  description = "lambda etl"
}
s3_landing = {
  name = "weather_landing"
}

s3_transformed = {
  name = "weather_transformed"
}

job_name = "weather_data_quality"