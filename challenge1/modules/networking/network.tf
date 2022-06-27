# Custom VPC
resource "google_compute_network" "main" {
  name = "main"
  auto_create_subnetworks = false
}

# Public Subnet for web teir
resource "google_compute_subnetwork" "public-subnet" {
  name          = "public"
  ip_cidr_range = var.ip_cidr_range_public
  region        = var.gcp_region
  network       = google_compute_network.main.id
}

# Private Subnet for app tier
resource "google_compute_subnetwork" "private-subnet" {
  name          = "private-subnet"
  ip_cidr_range = var.ip_cidr_range_public
  region        = var.gcp_region
  network       = google_compute_network.main.id
}

# Generates  Global Ip address for  VPC Peering
resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.main.id
}

# Private VPC connection with a GCP service provider
resource "google_service_networking_connection" "main_vpc_connection" {
  network                 = google_compute_network.main.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
