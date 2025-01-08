variable "bucket_name" {
  description = "The name of the Google Cloud Storage bucket."
  type        = string
}

variable "bucket_location" {
  description = "The location of the Google Cloud Storage bucket."
  type        = string
}

variable "bucket_storage_class" {
  description = "The storage class of the Google Cloud Storage bucket."
  type        = string
}

variable "bucket_force_destroy" {
  description = "Set to true to allow Terraform to destroy non-empty buckets."
  type        = bool
}