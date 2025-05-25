module "network" {
  source = "./network"
  availability_zones = var.availability_zones
}

module "security_groups" {
  source = "./security_groups"
  vpc = module.network.vpc
}

module "auto-scaling" {
  source = "./auto-scaling"
  image_ami = data.aws_ami.ubuntu.image_id
  frontend_sg = module.security_groups.frontend_sg
  backend_sg = module.security_groups.backend_sg
  private_subnets = module.network.private_subnets
  public_subnets = module.network.public_subnets
  frontend_tg_arn = module.load-balancer.frontend_target_group
  backend_tg_arn = module.load-balancer.backend_target_group
}

module "database" {
  source = "./database"
  private_subnets = module.network.private_subnets
  db_sg = module.security_groups.database_sg
}

module "load-balancer" {
  source = "./load-balancer"
  vpc = module.network.vpc
  public_subnets = module.network.public_subnets
  private_subnets = module.network.private_subnets
  frontend_lb_sg = module.security_groups.frontend_lb_sg
  backend_lb_sg = module.security_groups.backend_lb_sg
}

module "lambda" {
  source = "./lambda"
  region = var.region
}
