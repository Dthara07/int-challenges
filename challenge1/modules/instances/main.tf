
# Data source for the available zones
data "google_compute_zones" "available" {
}
# Web Tier Compute Engine instances - Each instance per zone
resource "google_compute_instance" "vm-web" {
  count = length(data.google_compute_zones.available.names)
  name = "vm-web-${count.index}"
  description = "This is the virtual machine for web tier"
  zone = data.google_compute_zones.available.names[count.index]
  tags = ["web"]
  
  allow_stopping_for_update = true

  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "20"
    }
  }
  
  labels = {
    name = "vm-web"
    machine_type = "e2-micro"
  }

  network_interface {
    network = "main"
    subnetwork = var.public-subnet
    access_config {
    }  
  }

  # Fetch the instance name from  the metadata in the startup script
  metadata = {
    metaKey="vm-web-${count.index}"
  }
  metadata_startup_script = file("scripts/startup_script.sh")
}

# App Tier Compute Engine instances - Each instance per zone
resource "google_compute_instance" "vm-app" {
  count = length(data.google_compute_zones.available.names)
  name = "vm-app-${count.index}"
  description = "This is the virtual machine for app"
  zone = data.google_compute_zones.available.names[count.index]
  tags = ["app"]
  allow_stopping_for_update = true

  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
      size = "20"
    }
  }
  labels = {
    name = "vm-app"
    machine_type = "e2-micro"
  }
    network_interface {
    network = "main"
    subnetwork = var.private-subnet
  }
}

