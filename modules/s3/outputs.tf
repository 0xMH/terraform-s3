output "id" {
  description = "Name of the bucket"
  value       = concat(aws_s3_bucket.b.*.id, [""])[0]
}

output "arn" {
  description = "ARN of the bucket"
  value       = concat(aws_s3_bucket.b.*.arn, [""])[0]
}

output "bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = concat(aws_s3_bucket.b.*.bucket_domain_name, [""])[0]
}
