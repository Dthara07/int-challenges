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
