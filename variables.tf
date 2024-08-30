# variables.tf
variable "project" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "global_tags" {
    description = "Global tags for all resources"
    type = map(string)
  
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "allowed_ports" {
  description = "List of ports allowed for the EC2 instances"
  type        = list(number)
}

variable "instance_type" {
    description = "instance type of ec2 instance"
    type = string
  
}

variable "instance_image" {
    description = "instance image of ec2 instance"
    type = string
  
}

variable "enable_public_ip" {
    description = "enable public ip address of ec2 instance"
    type = bool
  
}

variable "aws_iam_instance_profile" {
  description = "The IAM instance profile to attach to the instances"
  type        = string
}

variable "instances_config" {
  description = "Configuration for each EC2 instance"
  type = map(object({
    name = string
  }))
  
}