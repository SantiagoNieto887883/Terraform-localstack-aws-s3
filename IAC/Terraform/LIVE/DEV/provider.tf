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

provider "aws" {
#  region                      = "us-east-1"
#  access_key                  = "test"
#  secret_key                  = "test"
  region  = var.aws_region
  profile = var.profile

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true
  

# Endpoints
  endpoints {
    s3  = "http://localhost:4566"
    iam = "http://localhost:4566"
    sts = "http://localhost:4566"
  }

# TAGS
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}