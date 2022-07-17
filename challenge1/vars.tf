variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
}

variable "db_user_name" {
  type        = string
  description = "Cloud SQL DB user name"
}

variable "db_user_password" {
  type        = string
  description = "Cloud SQL DB password"
}