# Terraform AWS S3 Module

## Features

- S3 bucket creation
- Server Side Encryption (SSE) using the default aws/s3 CMK or custom AWS KMS
  customer master key.
- Lifecycle rules
- Support for Custom S3 bucket policy

## Notes
- As per AWS [docs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-transition-general-considerations.html)
  30-day minimum applies when you specify a transition from S3 to Standard-IA  
- The transition to Glacier must be 30 days more than the Standard-IA
  transition
- AWS 3 deprecated the region argument on the S3 Bucket resource, so if you try
  to use this module with AWS 3, it will fail.
## Examples

The following are guides for the different types of implementations supported by this module

- [basic](https://github.com/0xMH/terraform-s3/tree/master/examples/basic)
- [custom-policy](https://github.com/0xMH/terraform-s3/tree/master/examples/custom-policy)
- [encrypted](https://github.com/0xMH/terraform-s3/tree/master/examples/encrypted)
