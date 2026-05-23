module "app_storage" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
  kms_key_arn = var.kms_key_arn

  tags = {
    Project = "davivienda-platform"
    Owner   = "platform-engineering"
  }
}
