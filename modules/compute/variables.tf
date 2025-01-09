variable "image_family" {
  description = "Family of the image to use."
  type        = string
}

variable "image_project" {
  description = "Project ID for the image."
  type        = string
}

variable "health_check_interval" {
  description = "Interval for health check in seconds."
  type        = number
}

variable "health_check_timeout" {
  description = "Timeout for health check in seconds."
  type        = number
}

variable "health_check_path" {
  description = "Path to check for health check."
  type        = string
}

variable "health_check_port" {
  description = "Port for health check."
  type        = number
}

variable "source_ranges" {
  description = "Source IP ranges allowed for the firewall."
  type        = list(string)
}

variable "allowed_ports" {
  description = "List of allowed ports for the firewall."
  type        = list(string)
}

variable "machine_type" {
  description = "Machine type for the instance."
  type        = string
}

variable "startup_script_path" {
  description = "Path to the startup script for the VM."
  type        = string
}

variable "target_size" {
  description = "Target size for the instance group."
  type        = number
}

variable "auto_healing_initial_delay" {
  description = "Initial delay for auto-healing in seconds."
  type        = number
}

variable "name" {
  description = "The name of the instance prefix."
  type        = string
}
