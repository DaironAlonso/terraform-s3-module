output "bucket_id" {
  description = "Nombre del bucket provisionado."
  value       = module.app_storage.bucket_id
}

output "bucket_arn" {
  description = "ARN del bucket provisionado."
  value       = module.app_storage.bucket_arn
}