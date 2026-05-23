output "bucket_id" {
  description = "Name of the provisioned bucket."
  value       = module.app_storage.bucket_id
}

output "bucket_arn" {
  description = "ARN of the provisioned bucket."
  value       = module.app_storage.bucket_arn
}
