# Input variable definitions

variable "nodejs_version" {
  description = "Nodejs version for running lambda functions."
  type        = string
  default     = "nodejs14.x"
}

variable "source_code_bucket" {
  description = "Source code bucket name in AWS."
  type        = string
  default     = "terraform-uploads"
}

variable "hello_world_file" {
  description = "HelloWorld function source code file name."
  type        = string
  default     = "hello-world.zip"
}

variable "trigger_file" {
  description = "Trigger function source code file name."
  type        = string
  default     = "trigger.zip"
}

variable "hello_world_function_name" {
  description = "Hello World lambda function."
  type        = string
  default     = "HelloWorld"
}

variable "hello_world_function_sqs" {
  description = "Hello World lambda function triggering queue."
  type        = string
  default     = "terraform-example-queue.fifo"
}

variable "trigger_function_name" {
  description = "Trigger SQS that will call the mapped lambda function."
  type        = string
  default     = "TriggerSQS"
}
