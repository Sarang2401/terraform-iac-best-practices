provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../../modules/vpc"

  cidr = var.vpc_cidr
  env  = var.environment
}
