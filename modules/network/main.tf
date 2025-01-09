resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "webserver_subnet" {
  name          = var.webserver_subnet_name
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.webserver_subnet_ip_cidr_range
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = var.db_subnet_name
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.db_subnet_ip_cidr_range
}

resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_ip_address_name
  purpose       = var.private_ip_address_purpose
  address_type  = var.private_ip_address_type
  prefix_length = var.private_ip_prefix_length
  network       = google_compute_network.vpc_network.name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.name
  service                 = var.private_vpc_service
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

output "private_vpc_connection" {
  value = google_service_networking_connection.private_vpc_connection
}
output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}

output "webserver_subnet_id" {
  value = google_compute_subnetwork.webserver_subnet.id
}

output "db_subnet_id" {
  value = google_compute_subnetwork.db_subnet.id
}