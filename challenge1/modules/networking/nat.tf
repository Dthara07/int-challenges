# Cloud router
resource "google_compute_router" "router" {
  name    = "router"
  network = google_compute_network.main.id
  bgp {
    asn            = 64514 # Fixed value for this router resource
    advertise_mode = "CUSTOM"
  }
}

# NAT Gateway
resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "private-subnet"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  # depends_on = [
  #   google_compute_subnetwork.private-subnet
  # ]
}