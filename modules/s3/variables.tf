variable "bucket_name" {
  description = "Globally unique name for the S3 bucket."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9\\-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "The bucket name must be between 3 and 63 characters, lowercase alphanumeric and hyphens only."
  }
}

variable "environment" {
  description = "Deployment environment (e.g. dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Allowed values for environment are: dev, staging, prod."
  }
}

variable "kms_key_arn" {
  description = "ARN of a customer-managed KMS key. When null, AES-256 (SSE-S3) is used."
  type        = string
  default     = null
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
