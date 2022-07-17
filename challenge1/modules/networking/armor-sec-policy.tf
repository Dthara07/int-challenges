resource "google_compute_security_policy" "policy" {
  name = "my-policy"

  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["35.246.125.70/32"]
      }
    }
    description = "Deny access to IPs in 35.246.125.70/32"
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "default rule"
  }
}


resource "google_compute_instance" "test_siege_vm" {
  name = "test_siege-vm"
  description = "Stress test the HTTP load balancer"
  zone = "europe-west2-a"
  
  allow_stopping_for_update = true

  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "20"
    }
  }

  network_interface {
    network = "main"
    subnetwork = var.ip_cidr_range_private_subnet_1
    access_config {
    }  
  }
  # Fetch the instance name from  the metadata in the startup script
  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      set -euo pipefail

      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      sudo apt-get -y install siege
    EOF1
  }
}