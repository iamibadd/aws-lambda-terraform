# To deploy an AWS Lambda function, you must package it in an archive containing the function source code and any dependencies.
# Generates an archive from content, a file, or directory of files.
# "source" is your own name for identifying "archive_file". (same as variable)

# Archive source code for HelloWorld lambda function
data "archive_file" "hello_world_source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/${var.hello_world_file}"
  excludes    = ["trigger.js", "node_modules", "package.json", "package-lock.json"]
}

# Archive source code for TriggerSQS lambda function
data "archive_file" "trigger_source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/${var.trigger_file}"
  excludes    = ["index.js", "node_modules", "package.json", "package-lock.json"]
}

# Archive source dependencies for lambda functions
data "archive_file" "layers" {
  type        = "zip"
  source_dir  = "${path.module}/layers"
  output_path = "${path.module}/layers.zip"
}