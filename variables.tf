variable "root_password" {
  description = "Root password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "db_user_password" {
  description = "Password for the database user"
  type        = string
  sensitive   = true
}