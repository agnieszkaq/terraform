variable "vpc_network" {}
variable "webserver_subnet_id" {}

data "google_compute_image" "my_image" {
  family  = var.image_family
  project = var.image_project
}

resource "google_compute_health_check" "http" {
  name               = "${var.name}-health-check"
  check_interval_sec = var.health_check_interval
  timeout_sec        = var.health_check_timeout

  http_health_check {
    request_path = var.health_check_path
    port         = var.health_check_port
  }
}

resource "google_compute_firewall" "ports_allow" {
  name          = "${var.name}-network-access"
  network       = var.vpc_network
  source_ranges = var.source_ranges
  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }
}

resource "google_compute_instance_template" "server" {
  name         = "${var.name}-instance-template"
  machine_type = var.machine_type
  disk {
    source_image = data.google_compute_image.my_image.self_link
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = var.vpc_network
    subnetwork = var.webserver_subnet_id
    access_config {}
  }

  metadata_startup_script = file(var.startup_script_path)
}

resource "google_compute_instance_group_manager" "server" {
  name               = "${var.name}-group-manager"
  base_instance_name = var.name
  version {
    instance_template = google_compute_instance_template.server.id
  }
  target_size = var.target_size

  auto_healing_policies {
    health_check      = google_compute_health_check.http.id
    initial_delay_sec = var.auto_healing_initial_delay
  }
}
