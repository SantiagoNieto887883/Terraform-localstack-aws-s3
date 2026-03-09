# verificar la cuenta donde aplica

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

# referencia de modulos

module "S3" {
  source = "../../MODULES/S3"

  bucket_Name = var.bucket_Name
}