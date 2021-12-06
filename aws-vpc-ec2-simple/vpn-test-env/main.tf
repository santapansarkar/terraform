provider "aws" {
  region = "us-east-1"

}

module "vpc" {

  source                    = "../modules/vpc"
  cidr_range                = "10.0.0.0/16"
  tenancy                   = "default"
  environment_tag           = "self-vpn"
  module_name               = "networking"
  vpc_name                  = "private-vpc"
  vpn_subnet_cidr_range     = "10.0.2.0/24"
  private_subnet_cidr_range = "10.0.1.0/24"
}

module "ec2" {

  source                   = "../modules/ec2"
  environment_tag          = "self-vpn"
  module_name              = "compute"
  vpc_id                   = module.vpc.vpc_id
  private_vm_ami           = "ami-04902260ca3d33422"
  private_vm_instance_type = "t2.micro"
  ec2_key_pair             = "us-east-1-KP"
  private_vm_subnet_id     = module.vpc.self_vpn_private_id

}

