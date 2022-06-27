# resource "google_compute_address" "static" {
#   name = "apache"
# }

resource "google_compute_instance" "vm-internal" {
  name = "vm-internal"
  description = "This is the virtual machine for app"
  zone = var.zone
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
    name = "apache"
    machine_type = "e2-micro"
  }

  network_interface {
    network = "main"
    subnetwork = var.private-subnet
  }

  metadata_startup_script = file("scripts/startup_script.sh")
}

resource "google_compute_instance" "vm-bastion" {
  name = "vm-bastion"
  description = "Bastion VM"
  zone = var.zone
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
    name = "vm-bastion"
    machine_type = "e2-micro"
  }

  network_interface {
    network = "main"
    subnetwork = var.public-subnet
    access_config {
    }  
  }
}