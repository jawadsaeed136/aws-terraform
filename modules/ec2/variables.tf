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

variable "instance_type" {
    description = "instance type of ec2 instance"
    type = string
  
}

variable "instance_image" {
    description = "instance image of ec2 instance"
    type = string
  
}

variable "public_subnet_ids" {
  type = list(string)
  description = "Public subnet IDs passed from network module"
}

variable "vpc_id" {
    description = "ID of the VPC"
    type = string
  
}

variable "private_subnet_ids" {
  type = list(string)
  description = "Private subnet IDs passed from network module"
}

variable "aws_iam_instance_profile" {
  description = "The IAM instance profile to attach to the instances"
  type        = string
}

variable "allowed_ports" {
  description = "List of ports allowed for the EC2 instances"
  type        = list(number)
}

variable "enable_public_ip" {
  description = "Flag to enable public IP on instances"
  type        = bool
}

variable "instances_config" {
  description = "Configuration for each EC2 instance"
  type = map(object({
    name = string
  }))
}
