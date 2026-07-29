variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "db_username" {
  type = string
}

variable "db_password" {

  type      = string
  sensitive = true

  validation {

    condition = length(var.db_password) >= 8

    error_message = "Database password must contain at least 8 characters."

  }

}

variable "db_name" {
  type = string
}

variable "rds_security_group_id" {
  type = string
}