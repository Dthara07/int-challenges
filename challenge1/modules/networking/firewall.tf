resource "google_compute_firewall" "web-firewall" {
    name = "web-firewall"
    network = "main"
    description = "Allow http/https for all source range"
    
    allow {
      ports = ["22"]
      protocol = "tcp"
    }
    source_ranges = ["0.0.0.0/0"]
    
    priority = 1000
}

# resource "google_compute_firewall" "deny-web-to-db-egress" {
#     name = "db-firewall"
#     network = "main"
#     description = "Deny all from source web to db"
#     direction = "EGRESS"
#     deny {
#       protocol = "all"
#     }

#     target_tags = ["web"]
#     destination_ranges = ["10.176.0.3/32"]

#     priority = 1000
# }