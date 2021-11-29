provider "aws" {
  region = "us-east-1"

}

module "vpc" {

  source                          = "../modules/vpc"
  cidr_range                      = "10.0.0.0/16"
  tenancy                         = "default"
  environment_tag                 = "eb-ci-cd"
  module_name                     = "networking"
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
  public_subnet_cidr_range        = "10.0.159.0/24"
}

module "ec2" {

  source                         = "../modules/ec2"
  environment_tag                = "eb-ci-cd"
  module_name                    = "compute"
  vpc_id                         = module.vpc.vpc_id
  control_vm_ami                 = "ami-04902260ca3d33422"
  control_vm_instance_type       = "t3.medium"
  jumphost_vm_ami                = "ami-04902260ca3d33422"
  jumphost_vm_instance_type      = "t2.micro"
  forgerock_rms_vm_ami           = "ami-005b7876121b7244d"
  forgerock_rms_vm_instance_type = "t3.large"
  ec2_key_pair                   = "eb-ci-cd-kp"
  jumphost_vm_subnet_id          = module.vpc.jumphostvm_subnet_id
  control_vm_subnet_id           = module.vpc.controlvm_subnet_id
  forgerock_rms_vm_subnet_id     = module.vpc.forgerockrmsvm_subnet_id
}

