provider "aws" {
  region = "us-east-1"

}

module "vpc" {

  source                = "../modules/vpc"
  cidr_range            = "10.0.0.0/16"
  tenancy               = "default"
  vpc_name              = "eb-vpc"
  eks_subnet_cidr_range = "10.0.1.0/24"

}