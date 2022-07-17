# forwarding rule
resource "google_compute_forwarding_rule" "l7_ilb_forwarding_rule" {
  name                  = "l7-ilb-forwarding-rule"
  region                = var.gcp_region
  depends_on            = [google_compute_subnetwork.proxy_subnet]
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = var.port_range
  target                = google_compute_region_target_http_proxy.default.id
  network               = google_compute_network.main.id
  subnetwork            = google_compute_subnetwork.private_subnet_2.id
  network_tier          = "PREMIUM"
}

# HTTP target proxy
resource "google_compute_region_target_http_proxy" "default" {
  name     = "l7-ilb-target-http-proxy"
  region   = var.gcp_region
  url_map  = google_compute_region_url_map.default.id
}

# URL map
resource "google_compute_region_url_map" "default" {
  name            = "l7-ilb-regional-url-map"
  region          = var.gcp_region
  default_service = google_compute_region_backend_service.default.id
}

# backend service
resource "google_compute_region_backend_service" "default" {
  name                  = "l7-ilb-backend-subnet"
  region                = var.gcp_region
  protocol              = "HTTP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.autohealing.id]
  backend {
    group           = google_compute_region_instance_group_manager.vm_app_igm.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# instance template
resource "google_compute_instance_template" "vm_app_template" {
  name         = "l7-ilb-mig-template"
  machine_type = "e2-small"
  tags         = ["http-app-server"]

  network_interface {
    network    = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.private_subnet_2.id
  }
  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }

  # install nginx and serve a simple web page
  metadata_startup_script = file("scripts/nginx_startup_script.sh")
  lifecycle {
    create_before_destroy = true
  }
}

#MIG
resource "google_compute_region_instance_group_manager" "vm_app_igm" {
  name = "l7-ilb-mig1"

  base_instance_name         = "vm-app"
  region                     = var.gcp_region
  distribution_policy_zones  = data.google_compute_zones.available.names

  version {
    instance_template = google_compute_instance_template.vm_app_template.id
  }

  target_size  = 3

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

