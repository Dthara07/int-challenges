variable "zone" {
  description = "GCP zone name."
  type        = string
  default     = "europe-west2-a"
}

variable "private-subnet" {
  description = "Private Subnet"
  type        = string
}

variable "public-subnet" {
  description = "Public Subnet"
  type        = string
}
