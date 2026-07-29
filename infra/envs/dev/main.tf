module "network" {

  source = "../../modules/network"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2

}

module "security" {

  source = "../../modules/security"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.network.vpc_id

}

module "rds" {

  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  private_subnet_ids = module.network.private_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id

  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name

}

module "alb" {

  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.network.vpc_id

  public_subnet_ids = module.network.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

}

module "ecs" {

  source = "../../modules/ecs"

  project_name = var.project_name

  environment = var.environment

  vpc_id = module.network.vpc_id

  private_subnet_ids = module.network.private_subnet_ids

  ecs_security_group_id = module.security.ecs_security_group_id

  target_group_arn = module.alb.target_group_arn

  aws_region = var.aws_region

}