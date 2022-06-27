resource "google_compute_network" "main" {
  name = "main"
  auto_create_subnetworks = false
}

# Public Subnet
resource "google_compute_subnetwork" "public-subnet" {
  name          = "public"
  ip_cidr_range = "10.154.0.0/24"
  region        = var.gcp_region
  network       = google_compute_network.main.id
}

# Private Subnets
resource "google_compute_subnetwork" "private-subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.154.2.0/24"
  region        = var.gcp_region
  network       = google_compute_network.main.id
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.main.id
}

resource "google_service_networking_connection" "main_vpc_connection" {
  network                 = google_compute_network.main.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
