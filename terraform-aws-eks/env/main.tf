module "vpc" {

  source              = "../modules/vpc"
  vpc_cidr_block      = "10.0.0.0/16"
  vpc_env             = "dev"
  vpc_name            = "terraform"
  public_subnet_name  = "terraform-public-subnet"
  private_subnet_name = "terraform-private-subnet"
}




locals {
  project_name = "terraform-local"
}


/*
module "ec2" {
  source                    = "../modules/ec2"
  private_vm_ami            = "ami-0c2b8ca1dad447f8a"
  private_vm_instance_type  = "t2.micro"
  vpc_id                    = module.vpc.vpc_id
  jumphost_vm_ami           = "ami-0c2b8ca1dad447f8a"
  jumphost_vm_instance_type = "t2.micro"
  ec2_key_pair              = "terraform"
  environment_tag           = local.project_name
  jumphost_vm_subnet_id     = module.vpc.jumphost_vm_subnet_id
  private_vm_subnet_id      = module.vpc.private_vm_subnet_id

}
*/