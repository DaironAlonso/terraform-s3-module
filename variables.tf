variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "kms_key_arn" {
  description = "Optional ARN of a customer-managed KMS key."
  type        = string
  default     = null
}

variable "aws_region" {
  description = "AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}
