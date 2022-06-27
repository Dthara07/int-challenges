variable "ip_cidr_range" {
  description = "Ip cidr range"
  type        = string
  default     = "10.2.0.0/16"
}

variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "europe-west2"
}

variable "gcp_zone" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "europe-west2-a"
}

variable "gcp_project" {
  type        = string
  description = "Project to use for this config"
  default = "rcgnaecomoffshorepdp1000105852"
}

# variable "private-vpc-subnet" {
#   type        = string
#   description = "Private vpc  subnet"
# }
