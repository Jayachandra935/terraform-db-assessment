output "db_endpoint" {

  description = "RDS Endpoint"

  value = aws_db_instance.postgres.endpoint

}

output "db_port" {

  description = "Database Port"

  value = aws_db_instance.postgres.port

}

output "db_name" {

  description = "Database Name"

  value = aws_db_instance.postgres.db_name

}