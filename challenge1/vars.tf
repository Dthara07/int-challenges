variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "europe-west2"
}

variable "gcp_zone" {
  type        = string
  description = "Zone to use for GCP provider"
  default     = "europe-west2-a"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
  default = "rcgnaecomoffshorepdp1000105852"
}