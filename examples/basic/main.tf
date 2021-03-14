provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "s3_basic" {
  source = "../../modules/s3"
  
  create = true
  bucket-name   = "unique-bucket-name-basic"
}
