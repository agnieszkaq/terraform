resource "google_storage_bucket" "storage" {
  name          = var.bucket_name
  location      = var.bucket_location
  storage_class = var.bucket_storage_class
  force_destroy = var.bucket_force_destroy
}