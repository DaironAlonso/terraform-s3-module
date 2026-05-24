output "bucket_id" {
  description = "Nombre (ID) del bucket S3."
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN del bucket S3."
  value       = aws_s3_bucket.this.arn
}

output "bucket_regional_domain_name" {
  description = "Nombre de dominio regional del bucket."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}