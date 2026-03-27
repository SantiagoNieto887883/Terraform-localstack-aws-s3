terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # SIN backend aquí (lo pasarás en terraform init -backend-config=...)
  #backend "s3" {}
}