provider "aws" {
  region = "us-east-1"

}

module "vpc" {

  source                          = "../modules/vpc"
  cidr_range                      = "10.0.0.0/16"
  tenancy                         = "default"
  vpc_name                        = "eb-vpc"
  eks_subnet_cidr_range           = "10.0.1.0/24"
  dab_subnet_cidr_range           = "10.0.2.0/24"
  control_vm_subnet_cidr_range    = "10.0.3.0/24"
  forgerock_rms_subnet_cidr_range = "10.0.4.0/24"

}