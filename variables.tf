variable "bucket_name" {
  description = "Nombre único global del bucket S3."
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "kms_key_arn" {
  description = "ARN opcional de una clave KMS administrada por el cliente."
  type        = string
  default     = null
}

variable "aws_region" {
  description = "Región de AWS donde se provisionarán los recursos."
  type        = string
  default     = "us-east-1"
}