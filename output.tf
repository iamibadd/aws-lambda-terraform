# Output value definitions
# Runs after the deployment succeed

output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."
  value       = aws_s3_object.hello_world_bucket.bucket
}

output "lambda_file" {
  description = "Name of the lambda zip file."
  value       = aws_s3_object.hello_world_bucket.id
}

output "function_name" {
  description = "Name of the lambda function."
  value       = aws_lambda_function.hello_world.function_name
}

output "sqs_queue" {
  description = "Url of the SQS queue."
  value       = aws_sqs_queue.hello_world_queue.url
}

output "hello_world_sqs_event_mapping" {
  description = "Uuid of event source mapping of HelloWorld lambda function and SQS queue."
  value       = aws_lambda_event_source_mapping.hello_world_sqs_mapping.uuid
}
