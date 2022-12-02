# Uploading the zip file to AWS s3 bucket. Redeploying will update the same file.
resource "aws_s3_object" "hello_world_bucket" {
  bucket = var.source_code_bucket
  key    = var.hello_world_file
  source = data.archive_file.hello_world_source.output_path
  etag   = filemd5(data.archive_file.hello_world_source.output_path)
}

resource "aws_s3_object" "trigger_bucket" {
  bucket = var.source_code_bucket
  key    = var.trigger_file
  source = data.archive_file.trigger_source.output_path
  etag   = filemd5(data.archive_file.trigger_source.output_path)
}

# Configures the Lambda function to use the bucket object containing your function code.
# It also sets the runtime to NodeJS 14.x, and assigns the handler to the handler function defined in index.js.
# The source_code_hash attribute will change whenever you update the code contained in the archive, which lets Lambda know that there is a new version of your code available.
# Finally, the resource specifies a role which grants the function permission to access AWS services and resources in your account.
resource "aws_lambda_function" "hello_world" {
  function_name    = var.hello_world_function_name
  s3_bucket        = aws_s3_object.hello_world_bucket.bucket
  s3_key           = aws_s3_object.hello_world_bucket.key
  runtime          = var.nodejs_version
  handler          = "index.handler" # handler function inside index.js file.
  source_code_hash = data.archive_file.hello_world_source.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  layers           = [aws_lambda_layer_version.layers.arn]
}

# Defines a log group to store log messages from your Lambda function for 30 days.
# By convention, Lambda stores logs in a group with the name /aws/lambda/<Function Name>.
resource "aws_cloudwatch_log_group" "hello_world_logs" {
  name              = "/aws/lambda/${aws_lambda_function.hello_world.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_function" "trigger" {
  function_name    = var.trigger_function_name
  s3_bucket        = aws_s3_object.trigger_bucket.bucket
  s3_key           = aws_s3_object.trigger_bucket.key
  runtime          = var.nodejs_version
  handler          = "trigger.handler" # handler function inside trigger.js file.
  source_code_hash = data.archive_file.trigger_source.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  layers           = [aws_lambda_layer_version.layers.arn]
}

resource "aws_cloudwatch_log_group" "trigger_logs" {
  name              = "/aws/lambda/${aws_lambda_function.trigger.function_name}"
  retention_in_days = 30
}
