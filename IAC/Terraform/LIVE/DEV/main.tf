# referencia de modulos

module "S3" {
  source = "../../MODULES/S3"

  bucket_Name = var.bucket_Name
  force_destroy = var.force_destroy
}