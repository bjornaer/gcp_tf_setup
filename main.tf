# setup the GCP provider
terraform {
  required_version = ">= 1.5.0"
  backend "gcs" {
    bucket = var.project_id
    prefix = "terraform/state"
  }
}

provider "google" {
  project     = var.app_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}

provider "google-beta" {
  project     = var.app_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region_1
  zone        = var.gcp_zone_1
}
