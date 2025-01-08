variable "vpc_network" {
  description = "VPC network name."
  type        = string
}

variable "db_subnet_id" {
  description = "ID of the subnet where the database will be."
  type        = string
}

variable "db_instance_name" {
  description = "Name of the SQL database instance."
  type        = string
}

variable "db_version" {
  description = "Database version."
  type        = string
}

variable "root_password" {
  description = "Root password for the database."
  type        = string
}

variable "tier" {
  description = "SQL instance tier."
  type        = string
}

variable "availability_type" {
  description = "Availability type of the SQL instance."
  type        = string
}

variable "backup_start_time" {
  description = "Backup start time in UTC."
  type        = string
}

variable "app_subnet_ip_cidr_range" {
  description = "CIDR range for the application subnet."
  type        = string
}

variable "db_name" {
  description = "Name of the database."
  type        = string
}

variable "db_user_name" {
  description = "Username for the database."
  type        = string
}

variable "db_user_password" {
  description = "Password for the database user."
  type        = string
}

variable "db_ports" {
  description = "List of ports allowed for the database."
  type        = list(string)
}