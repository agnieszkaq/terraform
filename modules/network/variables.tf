variable "vpc_network_name" {
  description = "Name of the VPC network."
  type        = string
}

variable "auto_create_subnetworks" {
  description = "Whether to automatically create subnetworks in the VPC."
  type        = bool
  default     = false
}

variable "webserver_subnet_name" {
  description = "Name of the application subnet."
  type        = string
}

variable "webserver_subnet_ip_cidr_range" {
  description = "IP CIDR range for the application subnet."
  type        = string
}

variable "db_subnet_name" {
  description = "Name of the database subnet."
  type        = string
  default     = "db-subnet"
}

variable "db_subnet_ip_cidr_range" {
  description = "IP CIDR range for the database subnet."
  type        = string
}
variable "private_ip_address_name" {
  description = "The name of the private IP address."
  type        = string
}

variable "private_ip_address_purpose" {
  description = "The purpose of the private IP address."
  type        = string
}

variable "private_ip_address_type" {
  description = "The type of the private IP address."
  type        = string
}

variable "private_ip_prefix_length" {
  description = "The prefix length of the private IP address."
  type        = number
}

variable "private_vpc_service" {
  description = "The service to connect to."
  type        = string
}