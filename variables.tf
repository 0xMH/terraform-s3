# S3 Bucket var
variable "create" {
  description = "Controls S3 creation"
  type        = bool
  default     = true
}

variable "bucket-name" {
  description = "Name of the resource. Conflicts with name_prefix"
  default     = "hamzatestttttt"
}

variable "acl" {
  description = "The canned ACL to apply"
  default     = "private"
}

variable "force_destroy" {
  description = "When set to true, will delete the bucket even if it is not empty"
  type        = bool
  default     = false
}

variable "infrequently_accessed_days" {
  description = "Number of days for infrequently_accessed policy"
  type        = number
  default     = 30
}

variable "glacier_days" {
  description = "Number of days for glacier policy"
  type        = number
  default     = 60
}

# KMS 
variable "kms_key_create" {
  description = "Controls kms key creation"
  type        = bool
  default     = true
}

# Bucket Policy
variable "policy_document" {
  description = "A JSON string containing a bucket policy which will be applied to the bucket"
  default     = ""
}

variable "grant_caller_access" {
  description = "When set to true, this will create a bucket policy that gives the bucket owner admin access"
  type        = bool
  default     = true
}
