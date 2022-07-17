resource "google_compute_firewall" "allow_ssh_main" {
    name = "allow-ssh-main"
    network = "main"
    description = "Allow http/https for all source range"
    
    allow {
      ports = ["22"]
      protocol = "tcp"
    }
    source_ranges = ["0.0.0.0/0"]
    depends_on = [
      google_compute_network.main
    ]
    priority = 1000
}

resource "google_compute_firewall" "allow_http_https_webs" {
    name = "allow-http-https-webs"
    network = "main"
    description = "Allow http/https for all source range"
    
    allow {
      ports = ["80", "443"]
      protocol = "tcp"
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = [ "web" ]
    depends_on = [
      google_compute_network.main
    ]
    priority = 1000
}

# allow all access from IAP and health check ranges
resource "google_compute_firewall" "fw-iap" {
  name          = "l7-xlb-fw-allow-iap-hc"
  direction     = "INGRESS"
  network       = google_compute_network.main.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
  }
  target_tags = ["allow-web-health-check","http-app-server"]
}

# allow all access from IAP and health check ranges
# resource "google_compute_firewall" "fw-iap" {
#   name          = "l7-ilb-fw-allow-iap-hc"
#   direction     = "INGRESS"
#   network       = google_compute_network.main.id
#   source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
#   allow {
#     protocol = "tcp"
#   }
# }

# allow http from proxy subnet to backends
resource "google_compute_firewall" "fw-ilb-to-backends" {
  name          = "l7-ilb-fw-allow-ilb-to-backends"
  direction     = "INGRESS"
  network       = google_compute_network.main.id
  source_ranges = [var.ip_cidr_range_proxy_subnet]
  target_tags   = ["http-app-server"]
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }
}