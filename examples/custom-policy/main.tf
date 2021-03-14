provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
module "s3_custom_policy" {
  source = "../../modules/s3"
  create = true

  bucket-name = "random-bucket-name-sxbsssvkm"
  acl  = "public-read"
  force_destroy = "true"

  policy_document = concat(data.aws_iam_policy_document.public_read.*.json, [""])[0]
}

data "aws_iam_policy_document" "public_read" {
  count = 1

  statement {
    sid = "Public read access"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::${module.s3_custom_policy.id}/*"
    ]
  }
}
