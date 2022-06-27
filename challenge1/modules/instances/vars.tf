# Subnet for app tier passed from networks module
variable "private-subnet" {
  description = "Private Subnet"
  type        = string
}

# Subnet for web tier passed from networks module
variable "public-subnet" {
  description = "Public Subnet"
  type        = string
}
