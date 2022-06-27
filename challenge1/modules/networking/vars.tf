# Public subnet Ip range
variable "ip_cidr_range_public" {
  description = "Ip cidr range"
  type        = string
  default     = "10.154.0.0/24"
}

# Private subnet Ip range
variable "ip_cidr_range_private" {
  description = "Ip cidr range"
  type        = string
  default     = "10.154.2.0/24"
}

variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "europe-west2"
}