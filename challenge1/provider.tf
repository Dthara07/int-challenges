terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
  }
}
provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
}
