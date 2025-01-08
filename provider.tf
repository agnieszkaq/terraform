terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.15.0"
    }
  }
}

provider "google" {
  project     = "western-dock-447118-q6"
  region      = "europe-central2"
  zone        = "europe-central2-a"
  credentials = file("~/.gcp/service-account-key.json")
}
