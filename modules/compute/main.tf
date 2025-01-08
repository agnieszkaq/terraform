variable "vpc_network" {}
variable "app_subnet_id" {}

data "google_compute_image" "my_image" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_health_check" "web" {
  name               = "web-health-check"
  check_interval_sec = var.health_check_interval
  timeout_sec        = var.health_check_timeout

  http_health_check {
    request_path = var.health_check_path
    port         = var.health_check_port
  }
}

resource "google_compute_firewall" "ports_allow" {
  name          = "network-access"
  network       = var.vpc_network
  source_ranges = var.source_ranges
  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }
}

resource "google_compute_instance_template" "web_server_template" {
  name         = "web-server-vm-template"
  machine_type = var.machine_type
  disk {
    source_image = data.google_compute_image.my_image.self_link
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = var.vpc_network
    subnetwork = var.app_subnet_id
    access_config {}
  }

  metadata_startup_script = file(var.startup_script_path)
}

resource "google_compute_instance_group_manager" "web_manager" {
  name               = "web-server-group-manager"
  base_instance_name = "web-server"
  version {
    instance_template = google_compute_instance_template.web_server_template.id
  }
  target_size = var.target_size

  auto_healing_policies {
    health_check      = google_compute_health_check.web.id
    initial_delay_sec = var.auto_healing_initial_delay
  }
}
