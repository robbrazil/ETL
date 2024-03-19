resource "aws_cloudwatch_event_rule" "trigger" {
  name                = var.event_bridge_name
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule = aws_cloudwatch_event_rule.trigger.name
  arn  = var.target.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.trigger.arn
}