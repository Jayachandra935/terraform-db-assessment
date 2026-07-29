resource "aws_db_subnet_group" "main" {

  name = "${var.project_name}-${var.environment}-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {

    Name = "${var.project_name}-${var.environment}-db-subnet-group"

  }

}

resource "aws_db_instance" "postgres" {

  identifier = "${var.project_name}-${var.environment}-postgres"

  engine         = "postgres"
  engine_version = "16"
  instance_class = var.environment == "prod" ? "db.t3.small" : "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  publicly_accessible = false

  storage_encrypted = true

  backup_retention_period = var.environment == "prod" ? 7 : 1

  deletion_protection = var.environment == "prod" ? true : false

  skip_final_snapshot = var.environment == "dev" ? true : false

  apply_immediately = true

  tags = {
    Name = "${var.project_name}-${var.environment}-postgres"
  }
}