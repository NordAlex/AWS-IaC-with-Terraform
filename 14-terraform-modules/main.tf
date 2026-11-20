provider "aws" {
  region = var.aws_region
}

module "network" {
  source                = "./modules/network"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  availability_zones    = var.availability_zones
  public_subnet_names   = var.public_subnet_names
  public_subnet_cidrs   = var.public_subnet_cidrs
  internet_gateway_name = var.internet_gateway_name
  routing_table_name    = var.routing_table_name
}

module "network_security" {
  source           = "./modules/network_security"
  allowed_ip_range = var.allowed_ip_range

  ssh_security_group_name     = var.ssh_security_group_name
  public_security_group_name  = var.public_security_group_name
  private_security_group_name = var.private_security_group_name

  private_instance_id = var.private_instance_id
  public_instance_id  = var.public_instance_id

  vpc_id = module.network.vpc_id
}

module "application" {
  source               = "./modules/application"
  launch_template_name = var.launch_template_name
  ami_name             = var.ami_name
  aws_asg_name         = var.aws_asg_name
  load_balancer_name   = var.load_balancer_name

  vpc_id = module.network.vpc_id

  aws_region = var.aws_region

  subnet_ids = module.network.public_subnet_ids

  lb_http_security_group_id       = module.network_security.public_http_security_group_id
  ssh_instance_secirity_group_id  = module.network_security.ssh_security_group_id
  http_instance_secirity_group_id = module.network_security.private_http_security_group_id
}