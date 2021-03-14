# Terraform AWS S3 Module

## Notes
- As per AWS [docs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/lifecycle-transition-general-considerations.html)
  30-day minimum applies when you specify a transition from S3 to Standard-IA  
- The transition to Glacier must be 30 days more than the Standard-IA
  transition
- AWS 3 deprecated the region argument on the S3 Bucket resource, so if you try
  to use this module with AWS 3, it will fail.
