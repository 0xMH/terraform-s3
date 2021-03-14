terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.32.0"
    }
  }
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

resource "aws_s3_bucket_policy" "custom" {
  count  = var.create && !var.grant_caller_access ? 1 : 0
  bucket = aws_s3_bucket.b[0].id
  policy = var.policy_document

  depends_on = [aws_s3_bucket.b]
}

resource "aws_s3_bucket_policy" "owner" {
  count  = var.create && var.grant_caller_access ? 1 : 0
  bucket = aws_s3_bucket.b[0].id
  policy = data.aws_iam_policy_document.owner[0].json

  depends_on = [aws_s3_bucket.b]
}

data "aws_caller_identity" "caller" {}

data "aws_iam_policy_document" "owner" {
  count = var.create && var.grant_caller_access ? 1 : 0

  source_json = var.policy_document

  statement {
    sid = "Admin access for account owner"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.caller.account_id}:root"]
    }

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.b[0].id}",
      "arn:aws:s3:::${aws_s3_bucket.b[0].id}/*",
    ]
  }
}
