variable "aws_region" {

  description = "AWS Region"

  type = string

}

variable "environment" {

  description = "Deployment Environment"

  type = string

}

variable "project_name" {

  description = "Project Name"

  type = string

}

variable "vpc_cidr" {

  description = "VPC CIDR"

  type = string

}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "availability_zone_1" {
  type = string
}

variable "availability_zone_2" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type = string
}