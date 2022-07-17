# Private subnet Ip range
variable "ip_cidr_range_private_subnet_1" {
  description = "Ip cidr range"
  type        = string
  default     = "10.154.3.0/24"
}

# Private subnet Ip range
variable "ip_cidr_range_private_subnet_2" {
  description = "Ip cidr range"
  type        = string
  default     = "10.154.4.0/24"
}

variable "ip_cidr_range_proxy_subnet" {
  description = "Ip cidr range"
  type        = string
  default     = "10.154.5.0/24"
}

variable "gcp_region" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "europe-west2"
}

variable "port_range" {
  type        = string
  description = "Region to use for GCP provider"
  default     = "80"
}