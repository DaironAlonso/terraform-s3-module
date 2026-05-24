variable "bucket_name" {
  description = "Nombre único global del bucket S3."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9\\-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "El nombre debe tener entre 3 y 63 caracteres, solo minúsculas, números y guiones."
  }
}

variable "environment" {
  description = "Entorno de despliegue (ej: dev, staging, prod)."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Valores permitidos: dev, staging, prod."
  }
}

variable "kms_key_arn" {
  description = "ARN de clave KMS personalizada. Si es null, usa AES-256."
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas adicionales para todos los recursos."
  type        = map(string)
  default     = {}
}