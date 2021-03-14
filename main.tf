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


resource "aws_s3_bucket" "b" {
  bucket = var.bucket-name
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

