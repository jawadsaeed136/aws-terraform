# root module
module "vpc" {
  source = "./modules/vpc"

  project = var.project
  environment = var.environment
  common_tags = var.common_tags

  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

}

module "ec2" {
  source = "./modules/ec2"

  project = var.project
  environment = var.environment
  common_tags = var.common_tags

  instance_image = var.instance_image
  instance_type = var.instance_type

  enable_public_ip = true

  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  aws_iam_instance_profile = var.aws_iam_instance_profile
  
  allowed_ports = var.allowed_ports

  instances_config = var.instances_config
  
}