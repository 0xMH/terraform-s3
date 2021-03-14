# S3 Bucket var
variable "bucket-name" {
  description = "Name of the resource. Conflicts with name_prefix"
  default     = "hamzatestttttt"
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
