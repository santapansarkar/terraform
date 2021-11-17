provider "aws" {
  region = "us-east-1"

}

module "vpc" {

  source                          = "../modules/vpc"
  cidr_range                      = "10.0.0.0/16"
  tenancy                         = "default"
  vpc_name                        = "eb-vpc"
  eks_a_subnet_cidr_range         = "10.0.155.0/24"
  eks_b_subnet_cidr_range         = "10.0.156.0/24"
  dab_subnet_cidr_range           = "10.0.154.0/24"
  control_vm_subnet_cidr_range    = "10.0.150.0/24"
  forgerock_rms_subnet_cidr_range = "10.0.0.0/24"
  online_subnet_cidr_range        = "10.0.151.0/24"
  oam_subnet_cidr_range           = "10.0.153.0/24"
  trf_subnet_cidr_range           = "10.0.152.0/24"
  vpn_subnet_cidr_range           = "10.0.1.0/24"
  nat_subnet_cidr_range           = "10.0.100.0/24"
}