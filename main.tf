module "network" {
  source                         = "./modules/network"
  auto_create_subnetworks        = false
  db_subnet_ip_cidr_range        = "10.0.2.0/24"
  db_subnet_name                 = "db-subnet"
  vpc_network_name               = "web-vpc"
  private_ip_address_name        = "private-ip-address"
  private_ip_address_purpose     = "VPC_PEERING"
  private_ip_address_type        = "INTERNAL"
  private_ip_prefix_length       = 16
  private_vpc_service            = "servicenetworking.googleapis.com"
  webserver_subnet_name          = "webserver-subnet"
  webserver_subnet_ip_cidr_range = "10.0.1.0/24"
}

module "webserver" {
  source                     = "./modules/compute"
  allowed_ports              = ["80", "443", "22"]
  auto_healing_initial_delay = 120
  health_check_interval      = 5
  health_check_path          = "/healthz"
  health_check_port          = 80
  health_check_timeout       = 5
  image_family               = "debian-11"
  image_project              = "debian-cloud"
  machine_type               = "f1-micro"
  source_ranges              = ["0.0.0.0/0"]
  startup_script_path        = "./scripts/web_server_setup.sh"
  target_size                = 1
  name                       = "webserver"
  webserver_subnet_id        = module.network.webserver_subnet_id
  vpc_network                = module.network.vpc_network_id
}

module "database" {
  source                         = "./modules/database"
  backup_start_time              = "00:00"
  db_instance_name               = "web-database"
  db_name                        = "web-database"
  db_ports                       = ["5432"]
  db_subnet_id                   = module.network.db_subnet_id
  db_user_name                   = "admin"
  db_user_password               = var.db_user_password
  db_version                     = "POSTGRES_15"
  availability_type              = "REGIONAL"
  root_password                  = var.root_password
  tier                           = "db-f1-micro"
  private_vpc_connection         = module.network.private_vpc_connection
  webserver_subnet_ip_cidr_range = "10.0.1.0/24"
  vpc_network                    = module.network.vpc_network_id
}

module "storage" {
  source               = "./modules/storage"
  bucket_name          = "app-storage-agnieszkaq"
  bucket_location      = "EU"
  bucket_storage_class = "STANDARD"
  bucket_force_destroy = true
}