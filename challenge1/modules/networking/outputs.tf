output "main-vpc-connection" {
  description = "Private vpc connection"
  value       = "${google_service_networking_connection.main_vpc_connection}"
}

output "main-vpc-id" {
  description = "Private vpc Id"
  value       = "${google_compute_network.main.id}"
}

output "public-subnet" {
  description = "Public subnet Id"
  value       = "${google_compute_subnetwork.public-subnet.name}"
}

output "private-subnet" {
  description = "Private subnet name"
  value       = "${google_compute_subnetwork.private-subnet.name}"
}
