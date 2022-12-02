# Maps hello_world lambda function with SQS Queue
resource "aws_lambda_event_source_mapping" "hello_world_sqs_mapping" {
  event_source_arn = aws_sqs_queue.hello_world_queue.arn
  function_name    = aws_lambda_function.hello_world.arn
}