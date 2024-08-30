# terraform.tfvars
project               = "yap"
environment           = "dev"
vpc_cidr              = "10.0.0.0/16"
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24"]
private_subnet_cidrs  = ["10.0.4.0/24", "10.0.5.0/24","10.0.6.0/24"]
common_tags = {
  Project     = "yap"
  Environment = "dev"
}
global_tags = {
  Owner = "jawad"
  Application = "Frontend"
}
allowed_ports = [22, 80, 443]
instance_type = "t2.micro"
instance_image = "ami-0c38b837cd80f13bb"
enable_public_ip = true
aws_iam_instance_profile = "ec2RoleSsm"
instances_config = {
  "admin" = {
    name = "admin"
  },
  "user" = {
    name = "user"
  },
  "processor" = {
    name = "processor"
  },
  "nadra" = {
    name = "nadra"
  }
}
