# Input variable definitions

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-2"
}

variable "aws_access_key" {
  description = "AWS access key."
  type        = string
  default     = "asasas"
}

variable "aws_secret_key" {
  description = "AWS secret key."
  type        = string
  default     = "sasasaasa"
}

variable "aws_bucket_name" {
  description = "AWS bucket name."
  type        = string
  default     = "terraform-uploads"
}
