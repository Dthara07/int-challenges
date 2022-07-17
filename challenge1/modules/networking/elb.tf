data "google_compute_zones" "available" {
}

resource "random_id" "random" {
  byte_length = 2
}

# reserved IP address
resource "google_compute_global_address" "default" {
  name = "l7-xlb-static-ip"
}

# forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "l7-xlb-forwarding-rule-8"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}

# http proxy
resource "google_compute_target_http_proxy" "default" {
  name     = "l7-xlb-target-http-proxy-8"
  url_map  = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "l7-xlb-url-map-8"
  default_service = google_compute_backend_service.default.id
}

# backend service with custom request and response headers
resource "google_compute_backend_service" "default" {
  name                     = "l7-xlb-backend-service-8"
  protocol                 = "HTTP"
  port_name                = "my-port"
  load_balancing_scheme    = "EXTERNAL"
  timeout_sec              = 10
  enable_cdn               = true
  custom_request_headers   = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
  custom_response_headers  = ["X-Cache-Hit: {cdn_cache_status}"]
  health_checks            = [google_compute_health_check.autohealing.id]
  security_policy          = google_compute_security_policy.policy.id
  backend {
    group           = google_compute_region_instance_group_manager.vm_web_igm.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# instance template
resource "google_compute_instance_template" "vm_web_template" {
  name         = "vm-web-template-8"
  machine_type = "e2-small"
  tags         = ["allow-web-health-check"]

  network_interface {
    network    = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.private_subnet_1.id
  }
  disk {
    source_image = "debian-cloud/debian-10"
    auto_delete  = true
    boot         = true
  }
  metadata_startup_script = file("scripts/nginx_startup_script.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "vm_web_igm" {
  name = "vm-web-igm"

  base_instance_name         = "vm-web"
  region                     = var.gcp_region
  distribution_policy_zones  = data.google_compute_zones.available.names

  version {
    instance_template = google_compute_instance_template.vm_web_template.id
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

