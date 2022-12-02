# Creates an AWS SQS Queue for triggering HelloWorld lambda function
resource "aws_sqs_queue" "hello_world_queue" {
  name                        = var.hello_world_function_sqs
  fifo_queue                  = true
  content_based_deduplication = true
}

# SQS Policy Document, for SQS no role is required. In this case, we define policies in IAM Policy.
data "aws_iam_policy_document" "hello_world_sqs_policy_document" {
  statement {
    sid     = "SQSPolicyDocumentId"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [
      aws_sqs_queue.hello_world_queue.arn
    ]
  }
}

# SQS Policy
resource "aws_iam_policy" "hello_world_sqs_policy" {
  name   = "SQSPolicy"
  policy = data.aws_iam_policy_document.hello_world_sqs_policy_document.json
}

# SQS Policy Attachment
resource "aws_iam_role_policy_attachment" "hello_world_sqs_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.hello_world_sqs_policy.arn
}