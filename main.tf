terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.32.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


resource "aws_kms_key" "mykey" {
  count = var.kms_key_create ? 1 : 0
  description             = "This key is used to encrypt bucket objects"
}

resource "aws_s3_bucket" "b" {
  count = var.create ? 1 : 0

  bucket = var.bucket-name
  acl                 = var.acl
  force_destroy       = var.force_destroy

  server_side_encryption_configuration {

      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     =  "aws:kms"
          kms_master_key_id = var.kms_key_create ?  aws_kms_key.mykey[0].arn : ""
        
      }
    }
}

  lifecycle_rule {
    enabled = true

    transition {
      days          = var.infrequently_accessed_days
      storage_class = "STANDARD_IA" 
    }

    transition {
      days          = var.glacier_days
      storage_class = "GLACIER"
    }

  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

