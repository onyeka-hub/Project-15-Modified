
module "networks" {
  source                 = "./modules/networking"
  vpc_cidr               = var.vpc_cidr
  enable_dns_support     = true
  enable_dns_hostnames   = true
  name                   = var.name
  public_subnet          = var.public_subnet
  nginx_private_subnet   = var.nginx_private_subnet
  compute_private_subnet = var.compute_private_subnet
  data_private_subnet    = var.data_private_subnet
}

module "security" {
  source = "./modules/security"
  vpc_id = module.networks.vpc_id
}

module "autoscaling-groups" {
  source            = "./modules/autoscaling-group"
  image_id          = var.image_id
  nginx_image_id    = var.nginx_image_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  max_size          = var.max_size
  min_size          = var.min_size
  desired_capacity  = var.desired_capacity
  bastion-sg        = module.security.bastion-sg
  bastion_subnet    = module.networks.bastion_subnet
  bastion_subnet2   = module.networks.bastion_subnet2
  nginx-sg          = module.security.nginx-sg
  nginx_subnet      = module.networks.nginx_subnet
  nginx_subnet2     = module.networks.nginx_subnet2
  tooling-sg        = module.security.tooling-sg
  tooling_subnet    = module.networks.tooling_subnet
  tooling_subnet2   = module.networks.tooling_subnet2
  wordpress-sg      = module.security.wordpress-sg
  wordpress_subnet  = module.networks.wordpress_subnet
  wordpress_subnet2 = module.networks.wordpress_subnet2
}

module "loadbalancer" {
  source          = "./modules/alb"
  ext_alb_sg      = module.security.ext-alb-sg
  ext_alb_subnet  = module.networks.ext_alb_subnet
  ext_alb_subnet2 = module.networks.ext_alb_subnet2
  vpc_id          = module.networks.vpc_id
  int-alb-sg      = module.security.int-alb-sg
  int_alb_subnet  = module.networks.int_alb_subnet
  int_alb_subnet2 = module.networks.int_alb_subnet2
}

module "rds" {
  source       = "./modules/rds"
  data_subnet  = module.networks.data_subnet
  data_subnet2 = module.networks.data_subnet2
  data-sg      = module.security.data-sg
  name         = var.name
  db_name      = var.db_name
  username     = var.username
  password     = var.password
  multi_az     = var.multi_az
}

module "efs" {
  source      = "./modules/efs"
  efs-sg      = module.security.efs-sg
  efs_subnet  = module.networks.efs_subnet
  efs_subnet2 = module.networks.efs_subnet2
  name        = var.name
}

module "route53" {
  source     = "./modules/route53"
  name       = var.name
  alias-name = module.loadbalancer.alias-name
  zone_id    = module.loadbalancer.zone_id
}
