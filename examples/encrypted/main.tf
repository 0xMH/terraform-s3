provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

module "s3_kms" {
  source = "../../modules/s3"
  
  bucket-name   = "random-name-for-test-kms"
  create = true
  kms_key_create = true


}

