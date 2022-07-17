# Custom VPC
resource "google_compute_network" "main" {
  name = "main"
  auto_create_subnetworks = false
}

# Private Subnet for web teir
resource "google_compute_subnetwork" "private_subnet_1" {
  name          = "private-subnet-1"
  ip_cidr_range = var.ip_cidr_range_private_subnet_1
  region        = var.gcp_region
  network       = google_compute_network.main.id
}

# Private Subnet for app tier
resource "google_compute_subnetwork" "private_subnet_2" {
  name          = "private-subnet-2"
  ip_cidr_range = var.ip_cidr_range_private_subnet_2
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

# proxy-only subnet
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "l7-ilb-proxy-subnet"
  ip_cidr_range = var.ip_cidr_range_proxy_subnet
  region        = var.gcp_region
  purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  role          = "ACTIVE"
  network       = google_compute_network.main.id
}

# Private VPC connection with a GCP service provider
resource "google_service_networking_connection" "main_vpc_connection" {
  network                 = google_compute_network.main.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}
