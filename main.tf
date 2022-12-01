provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# To deploy an AWS Lambda function, you must package it in an archive containing the function source code and any dependencies.
# Generates an archive from content, a file, or directory of files.
# "archive_file_resource" is your own name for identifying "archive_file". (same as variable)
data "archive_file" "archive_file_resource" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/src.zip"
  excludes    = ["test.js"]
}

# Uploading the zip file to AWS s3 bucket. Redeploying will update the same file.
resource "aws_s3_object" "s3_object_resource" {
  bucket = var.aws_bucket_name
  key    = "uploaded-file.zip"
  source = data.archive_file.archive_file_resource.output_path
  etag   = filemd5(data.archive_file.archive_file_resource.output_path)
}

# Configures the Lambda function to use the bucket object containing your function code.
# It also sets the runtime to NodeJS 14.x, and assigns the handler to the handler function defined in index.js.
# The source_code_hash attribute will change whenever you update the code contained in the archive, which lets Lambda know that there is a new version of your code available.
# Finally, the resource specifies a role which grants the function permission to access AWS services and resources in your account.
resource "aws_lambda_function" "lambda_function_resource" {
  function_name    = "HelloWorld"
  s3_bucket        = aws_s3_object.s3_object_resource.bucket
  s3_key           = aws_s3_object.s3_object_resource.key
  runtime          = "nodejs14.x"
  handler          = "index.handler" # handler function inside index.js file.
  source_code_hash = data.archive_file.archive_file_resource.output_base64sha256
  role             = aws_iam_role.lambda_exec.arn
}

# Defines a log group to store log messages from your Lambda function for 30 days.
# By convention, Lambda stores logs in a group with the name /aws/lambda/<Function Name>.
resource "aws_cloudwatch_log_group" "lambda_function_resource" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function_resource.function_name}"
  retention_in_days = 30
}

# Defines an IAM role that allows Lambda to access resources in your AWS account.
resource "aws_iam_role" "lambda_exec" {
  name               = "serverless_lambda"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attaches a policy the IAM role.
# The AWSLambdaBasicExecutionRole is an AWS managed policy that allows your Lambda function to write to CloudWatch logs.
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

