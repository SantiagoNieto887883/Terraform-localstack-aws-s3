resource "aws_s3_bucket" "images" {
  bucket = var.bucket_Name
  force_destroy = var.force_destroy
}