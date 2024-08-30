# providers.tf
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
  backend "s3" {
    bucket = "testbusketforterraformstatefileversionthree"
    key    = "backend.tfstate"
    region = "eu-west-1"
    
  }
}


provider "aws" {
  region = "eu-west-1"
}