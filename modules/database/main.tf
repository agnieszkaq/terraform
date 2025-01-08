variable "private_vpc_connection" {}

resource "google_sql_database_instance" "db_instance" {
  name             = var.db_instance_name
  database_version = var.db_version
  root_password    = var.root_password

  depends_on = [var.private_vpc_connection]

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    backup_configuration {
      enabled    = true
      start_time = var.backup_start_time
    }
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_network
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_database" "default" {
  name     = var.db_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "default" {
  name     = var.db_user_name
  instance = google_sql_database_instance.db_instance.name
  password = var.db_user_password
}

resource "google_compute_firewall" "allow_db_access" {
  name    = "allow-db-access"
  network = var.vpc_network
  allow {
    protocol = "tcp"
    ports    = var.db_ports
  }
  source_ranges = [var.app_subnet_ip_cidr_range]
}