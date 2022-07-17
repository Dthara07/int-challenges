#  Private VPC connection with a GCP service provider, will be used in the creation of Sql instance
output "main-vpc-connection" {
  description = "Private vpc connection"
  value       = "${google_service_networking_connection.main_vpc_connection}"
}

# Custom VPC "main" id
output "main-vpc-id" {
  description = "Private vpc Id"
  value       = "${google_compute_network.main.id}"
}

# Subnet for web tier passed from networks module
output "private_subnet_1" {
  description = "Private subnet Id"
  value       = "${google_compute_subnetwork.private_subnet_1.name}"
}

# Subnet for app tier passed from networks module
output "private_subnet_2" {
  description = "Private subnet name"
  value       = "${google_compute_subnetwork.private_subnet_2.name}"
}
