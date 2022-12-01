# Output value definitions

output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."
  value       = aws_s3_object.s3_object_resource.id
}

output "function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.lambda_function_resource.function_name
}

